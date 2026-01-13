/// Content validation and metadata enrichment tool.
///
/// Validates all markdown content files have proper front matter
/// and enriches missing metadata from git history.
///
/// Usage: dart run tool/validate_content.dart [--fix] [--verbose]
library;

import 'dart:io';

import 'package:yaml/yaml.dart';

/// Required front matter fields (warning if missing).
const List<String> requiredFields = ['title', 'description'];

/// Optional fields that will be auto-populated if missing.
const List<String> autoPopulateFields = ['author'];

void main(List<String> args) async {
  final bool fix = args.contains('--fix');
  final bool verbose = args.contains('--verbose');
  final bool strict = args.contains('--strict');

  print('Content Validator');
  print('=' * 50);
  print('Mode: ${fix ? "Fix" : "Validate only"}');
  print('');

  final Directory contentDir = Directory('content');
  if (!await contentDir.exists()) {
    stderr.writeln('Error: content/ directory not found');
    exit(1);
  }

  final List<ValidationResult> results = [];
  int filesProcessed = 0;
  int filesModified = 0;
  int errors = 0;
  int warnings = 0;

  await for (final FileSystemEntity entity
      in contentDir.list(recursive: true)) {
    if (entity is! File) continue;
    if (!entity.path.endsWith('.md')) continue;
    if (entity.path.contains('/_')) continue;

    filesProcessed++;
    final ValidationResult result = await validateFile(entity, fix: fix);
    results.add(result);

    if (result.modified) filesModified++;
    errors += result.errors.length;
    warnings += result.warnings.length;

    if (verbose || result.hasIssues) {
      printResult(result, verbose: verbose);
    }
  }

  print('');
  print('=' * 50);
  print('Summary:');
  print('  Files processed: $filesProcessed');
  print('  Files modified:  $filesModified');
  print('  Errors:          $errors');
  print('  Warnings:        $warnings');

  if (strict && errors > 0) {
    stderr.writeln('\nValidation failed with $errors error(s)');
    exit(1);
  }

  if (errors > 0) {
    print('\nRun with --fix to auto-populate missing metadata');
  }

  exit(0);
}

class ValidationResult {
  final String filePath;
  final List<String> errors;
  final List<String> warnings;
  final List<String> info;
  final bool modified;

  ValidationResult({
    required this.filePath,
    this.errors = const [],
    this.warnings = const [],
    this.info = const [],
    this.modified = false,
  });

  bool get hasIssues => errors.isNotEmpty || warnings.isNotEmpty;
}

Future<ValidationResult> validateFile(File file, {bool fix = false}) async {
  final String relativePath =
      file.path.startsWith('content/') ? file.path : file.path.split('content/').last;
  final List<String> errors = [];
  final List<String> warnings = [];
  final List<String> info = [];
  bool modified = false;

  String content = await file.readAsString();

  // Parse front matter
  final RegExp frontmatterRegex =
      RegExp(r'^---\s*\n([\s\S]*?)\n---', multiLine: true);
  final RegExpMatch? match = frontmatterRegex.firstMatch(content);

  if (match == null) {
    errors.add('Missing front matter');
    return ValidationResult(
      filePath: relativePath,
      errors: errors,
      warnings: warnings,
      info: info,
    );
  }

  final String yamlContent = match.group(1) ?? '';
  Map<String, dynamic> frontmatter;

  try {
    final dynamic parsed = loadYaml(yamlContent);
    if (parsed is YamlMap) {
      frontmatter = Map<String, dynamic>.from(parsed);
    } else {
      frontmatter = {};
    }
  } catch (e) {
    errors.add('Invalid YAML in front matter: $e');
    return ValidationResult(
      filePath: relativePath,
      errors: errors,
      warnings: warnings,
      info: info,
    );
  }

  // Check required fields
  for (final String field in requiredFields) {
    if (!frontmatter.containsKey(field) ||
        frontmatter[field] == null ||
        frontmatter[field].toString().trim().isEmpty) {
      warnings.add('Missing required field: $field');
    }
  }

  // Check and auto-populate author
  if (!frontmatter.containsKey('author') ||
      frontmatter['author'] == null ||
      frontmatter['author'].toString().trim().isEmpty) {
    final String? author = await getGitAuthor(file.path);
    if (author != null) {
      if (fix) {
        // Add author to front matter
        content = await addFrontmatterField(file, 'author', author);
        await file.writeAsString(content);
        modified = true;
        info.add('Added author: $author');
      } else {
        warnings.add('Missing author (git author: $author)');
      }
    } else {
      warnings.add('Missing author (no git history found)');
    }
  }

  return ValidationResult(
    filePath: relativePath,
    errors: errors,
    warnings: warnings,
    info: info,
    modified: modified,
  );
}

/// Get the author of the file from git commit history.
Future<String?> getGitAuthor(String filePath) async {
  try {
    // Get the author of the first commit that added this file
    final ProcessResult result = await Process.run(
      'git',
      ['log', '--diff-filter=A', '--format=%an', '--', filePath],
      workingDirectory: Directory.current.path,
    );

    if (result.exitCode == 0) {
      final String output = result.stdout.toString().trim();
      if (output.isNotEmpty) {
        // Return the first line (author who created the file)
        return output.split('\n').first.trim();
      }
    }

    // Fallback: get the author of the most recent commit
    final ProcessResult fallbackResult = await Process.run(
      'git',
      ['log', '-1', '--format=%an', '--', filePath],
      workingDirectory: Directory.current.path,
    );

    if (fallbackResult.exitCode == 0) {
      final String output = fallbackResult.stdout.toString().trim();
      if (output.isNotEmpty) {
        return output;
      }
    }
  } catch (e) {
    // Git not available or error occurred
  }
  return null;
}

/// Add a field to the front matter of a file.
Future<String> addFrontmatterField(
    File file, String field, String value) async {
  String content = await file.readAsString();

  final RegExp frontmatterRegex =
      RegExp(r'^(---\s*\n)([\s\S]*?)(\n---)', multiLine: true);
  final RegExpMatch? match = frontmatterRegex.firstMatch(content);

  if (match == null) {
    return content;
  }

  final String before = match.group(1)!;
  String yaml = match.group(2)!;
  final String after = match.group(3)!;

  // Add the new field at the end of the front matter
  if (!yaml.endsWith('\n')) {
    yaml += '\n';
  }
  yaml += '$field: $value';

  return content.replaceFirst(frontmatterRegex, '$before$yaml$after');
}

void printResult(ValidationResult result, {bool verbose = false}) {
  final String icon = result.errors.isNotEmpty
      ? 'X'
      : result.warnings.isNotEmpty
          ? '!'
          : result.modified
              ? '*'
              : '.';

  print('[$icon] ${result.filePath}');

  for (final String error in result.errors) {
    print('    ERROR: $error');
  }

  for (final String warning in result.warnings) {
    print('    WARN:  $warning');
  }

  if (verbose) {
    for (final String info in result.info) {
      print('    INFO:  $info');
    }
  }
}
