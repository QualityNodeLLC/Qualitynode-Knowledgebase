/// Content validation and metadata enrichment tool.
///
/// Usage: dart run tool/validate_content.dart [--fix] [--verbose] [--strict]
library;

import 'dart:convert';
import 'dart:io';

import 'package:yaml/yaml.dart';

import 'content_policy.dart';

const List<String> requiredFields = <String>['title', 'description'];
const List<String> autoPopulateFields = <String>['author'];

Future<void> main(List<String> args) async {
  final bool fix = args.contains('--fix');
  final bool verbose = args.contains('--verbose');
  final bool strict = args.contains('--strict');
  final Directory contentDirectory = Directory('content');

  stdout.writeln('Content Validator');
  stdout.writeln('=' * 50);
  stdout.writeln('Mode: ${fix ? "Fix" : "Validate only"}');
  stdout.writeln('');

  if (!await contentDirectory.exists()) {
    stderr.writeln('Error: content/ directory not found');
    exitCode = 1;
    return;
  }

  final ContentValidationReport report = await validateContentDirectory(
    contentDirectory,
    fix: fix,
    searchIndexFile: File('web/search-index.json'),
  );

  for (final ValidationResult result in report.results) {
    if (verbose || result.hasIssues || result.modified) {
      printResult(result, verbose: verbose);
    }
  }

  stdout.writeln('');
  stdout.writeln('=' * 50);
  stdout.writeln('Summary:');
  stdout.writeln('  Files processed: ${report.filesProcessed}');
  stdout.writeln('  Files modified:  ${report.filesModified}');
  stdout.writeln('  Errors:          ${report.errorCount}');
  stdout.writeln('  Warnings:        ${report.warningCount}');

  final bool failed =
      report.errorCount > 0 || (strict && report.warningCount > 0);
  if (failed) {
    stderr.writeln(
      '\nValidation failed with ${report.errorCount} error(s) and '
      '${report.warningCount} warning(s)',
    );
    exitCode = 1;
  }
}

class ContentValidationReport {
  final int filesProcessed;
  final List<ValidationResult> results;

  const ContentValidationReport({
    required this.filesProcessed,
    required this.results,
  });

  int get filesModified =>
      results.where((ValidationResult result) => result.modified).length;

  int get errorCount => results.fold<int>(
    0,
    (int total, ValidationResult result) => total + result.errors.length,
  );

  int get warningCount => results.fold<int>(
    0,
    (int total, ValidationResult result) => total + result.warnings.length,
  );
}

class ValidationResult {
  final String filePath;
  final List<String> errors;
  final List<String> warnings;
  final List<String> info;
  final bool modified;

  const ValidationResult({
    required this.filePath,
    this.errors = const <String>[],
    this.warnings = const <String>[],
    this.info = const <String>[],
    this.modified = false,
  });

  bool get hasIssues => errors.isNotEmpty || warnings.isNotEmpty;
}

class ContentDocument {
  final File file;
  final String relativePath;
  final String route;
  final String content;
  final Map<String, dynamic> frontmatter;

  const ContentDocument({
    required this.file,
    required this.relativePath,
    required this.route,
    required this.content,
    required this.frontmatter,
  });

  bool get draft => frontmatter['draft'] == true;
  bool get hidden => frontmatter['hidden'] == true;
}

class _DocumentReadResult {
  final ContentDocument? document;
  final ValidationResult? validationResult;

  const _DocumentReadResult({this.document, this.validationResult});
}

Future<ContentValidationReport> validateContentDirectory(
  Directory contentDirectory, {
  bool fix = false,
  File? searchIndexFile,
}) async {
  final List<File> files = await _contentFiles(contentDirectory);

  final List<ContentDocument> documents = <ContentDocument>[];
  final List<ValidationResult> results = <ValidationResult>[];
  for (final File file in files) {
    final _DocumentReadResult readResult = await _readDocument(
      file,
      contentDirectory,
    );
    if (readResult.document != null) {
      documents.add(readResult.document!);
    }
    if (readResult.validationResult != null) {
      results.add(readResult.validationResult!);
    }
  }

  final Map<String, ContentDocument> documentsByRoute =
      <String, ContentDocument>{
        for (final ContentDocument document in documents)
          document.route: document,
      };
  final Set<String> publishedRoutes = documents
      .where((ContentDocument document) => !document.draft)
      .map((ContentDocument document) => document.route)
      .toSet();
  final Set<String> draftRoutes = documents
      .where((ContentDocument document) => document.draft)
      .map((ContentDocument document) => document.route)
      .toSet();

  for (final ContentDocument document in documents) {
    results.add(
      await _validateDocument(
        document,
        contentDirectory: contentDirectory,
        documentsByRoute: documentsByRoute,
        publishedRoutes: publishedRoutes,
        draftRoutes: draftRoutes,
        fix: fix,
      ),
    );
  }

  results.addAll(_validateProductManifest(contentDirectory, documentsByRoute));
  if (searchIndexFile != null && await searchIndexFile.exists()) {
    results.add(
      await _validateSearchIndex(
        searchIndexFile,
        publishedRoutes: publishedRoutes,
        draftRoutes: draftRoutes,
      ),
    );
  }

  return ContentValidationReport(
    filesProcessed: files.length,
    results: results,
  );
}

Future<List<ContentDocument>> loadContentDocuments(
  Directory contentDirectory,
) async {
  final List<ContentDocument> documents = <ContentDocument>[];
  for (final File file in await _contentFiles(contentDirectory)) {
    final _DocumentReadResult readResult = await _readDocument(
      file,
      contentDirectory,
    );
    if (readResult.document != null) {
      documents.add(readResult.document!);
    }
  }
  return documents;
}

Future<List<File>> _contentFiles(Directory contentDirectory) async {
  final List<File> files = await contentDirectory
      .list(recursive: true)
      .where(
        (FileSystemEntity entity) =>
            entity is File &&
            entity.path.endsWith('.md') &&
            !entity.path.split(Platform.pathSeparator).last.startsWith('_'),
      )
      .cast<File>()
      .toList();
  files.sort((File left, File right) => left.path.compareTo(right.path));
  return files;
}

Future<_DocumentReadResult> _readDocument(
  File file,
  Directory contentDirectory,
) async {
  final String relativePath = _relativeContentPath(file, contentDirectory);
  final String content = await file.readAsString();
  final RegExpMatch? match = RegExp(
    r'^---\s*\n([\s\S]*?)\n---',
    multiLine: true,
  ).firstMatch(content);
  if (match == null) {
    return _DocumentReadResult(
      validationResult: ValidationResult(
        filePath: relativePath,
        errors: const <String>['Missing front matter'],
      ),
    );
  }

  final String yamlContent = match.group(1) ?? '';
  try {
    final dynamic parsed = loadYaml(yamlContent);
    if (parsed is! YamlMap) {
      return _DocumentReadResult(
        validationResult: ValidationResult(
          filePath: relativePath,
          errors: const <String>['Front matter must be a YAML map'],
        ),
      );
    }
    return _DocumentReadResult(
      document: ContentDocument(
        file: file,
        relativePath: relativePath,
        route: contentRouteForRelativePath(relativePath),
        content: content,
        frontmatter: Map<String, dynamic>.from(parsed),
      ),
    );
  } on YamlException catch (error) {
    return _DocumentReadResult(
      validationResult: ValidationResult(
        filePath: relativePath,
        errors: <String>['Invalid YAML in front matter: $error'],
      ),
    );
  }
}

Future<ValidationResult> _validateDocument(
  ContentDocument document, {
  required Directory contentDirectory,
  required Map<String, ContentDocument> documentsByRoute,
  required Set<String> publishedRoutes,
  required Set<String> draftRoutes,
  required bool fix,
}) async {
  final List<String> errors = <String>[];
  final List<String> warnings = <String>[];
  final List<String> info = <String>[];
  bool modified = false;

  for (final String field in requiredFields) {
    final dynamic value = document.frontmatter[field];
    if (value == null || value.toString().trim().isEmpty) {
      warnings.add('Missing required field: $field');
    }
  }

  final dynamic authorValue = document.frontmatter['author'];
  if (authorValue == null || authorValue.toString().trim().isEmpty) {
    final String? author = await getGitAuthor(document.file.path);
    if (author != null && fix) {
      final String updated = await addFrontmatterField(
        document.file,
        'author',
        author,
      );
      await document.file.writeAsString(updated);
      modified = true;
      info.add('Added author: $author');
    } else if (author != null) {
      warnings.add('Missing author (git author: $author)');
    } else {
      warnings.add('Missing author (no git history found)');
    }
  }

  errors.addAll(validateTodoState(document.content, isDraft: document.draft));
  errors.addAll(validateCopyHygieneContent(document.content));
  if (!document.draft) {
    errors.addAll(validatePublishedContent(document.content));
    errors.addAll(
      _validateInternalLinks(
        document,
        contentDirectory: contentDirectory,
        documentsByRoute: documentsByRoute,
        publishedRoutes: publishedRoutes,
        draftRoutes: draftRoutes,
      ),
    );
  }

  return ValidationResult(
    filePath: document.relativePath,
    errors: errors,
    warnings: warnings,
    info: info,
    modified: modified,
  );
}

List<String> validateTodoState(String content, {required bool isDraft}) {
  if (!RegExp(r'<!--\s*TODO\b', caseSensitive: false).hasMatch(content)) {
    return const <String>[];
  }
  if (isDraft) {
    return const <String>[];
  }
  return const <String>['Published content contains a TODO marker'];
}

List<String> validatePublishedContent(String content) {
  final List<String> errors = <String>[];
  for (final ForbiddenContentRule rule in forbiddenPublishedContentRules) {
    if (RegExp(
      rule.pattern,
      caseSensitive: rule.caseSensitive,
    ).hasMatch(content)) {
      errors.add('Forbidden published content: ${rule.description}');
    }
  }

  final Iterable<RegExpMatch> supportAddresses = RegExp(
    r'support@[a-z0-9-]+(?:\.[a-z0-9-]+)+',
    caseSensitive: false,
  ).allMatches(content);
  for (final RegExpMatch match in supportAddresses) {
    final String address = (match.group(0) ?? '').toLowerCase();
    if (address != canonicalSupportEmail) {
      errors.add('Noncanonical support email: $address');
    }
  }
  return errors.toSet().toList();
}

List<String> validateCopyHygieneContent(String content) {
  final String prose = content
      .replaceAll(RegExp(r'```[\s\S]*?```'), '')
      .replaceAll(RegExp(r'`[^`\n]*`'), '')
      .replaceAll(RegExp(r'^\s*\|.*\|\s*$', multiLine: true), '');
  final List<String> errors = <String>[];
  for (final ForbiddenContentRule rule in forbiddenAllContentCopyRules) {
    if (RegExp(
      rule.pattern,
      caseSensitive: rule.caseSensitive,
    ).hasMatch(prose)) {
      errors.add('Forbidden copy in content: ${rule.description}');
    }
  }
  return errors.toSet().toList();
}

List<String> _validateInternalLinks(
  ContentDocument document, {
  required Directory contentDirectory,
  required Map<String, ContentDocument> documentsByRoute,
  required Set<String> publishedRoutes,
  required Set<String> draftRoutes,
}) {
  final List<String> errors = <String>[];
  for (final String rawLink in extractInternalLinks(document.content)) {
    final String route = normalizeInternalRoute(rawLink);
    if (route.startsWith('/assets/')) {
      final File asset = File(
        '${contentDirectory.parent.path}/web${route.split('#').first}',
      );
      if (!asset.existsSync()) {
        errors.add('Missing local asset: $rawLink');
      }
      continue;
    }
    if (draftRoutes.contains(route)) {
      errors.add('Published link targets draft content: $rawLink');
      continue;
    }
    if (!publishedRoutes.contains(route) ||
        !documentsByRoute.containsKey(route)) {
      errors.add('Broken internal link: $rawLink');
    }
  }
  return errors.toSet().toList();
}

List<String> extractInternalLinks(String content) {
  return RegExp(r'\]\((/[^)\s]+)\)')
      .allMatches(content)
      .map((RegExpMatch match) => match.group(1) ?? '')
      .where((String link) => link.isNotEmpty)
      .toList();
}

String normalizeInternalRoute(String rawLink) {
  String route = rawLink.trim();
  final int queryIndex = route.indexOf('?');
  final int fragmentIndex = route.indexOf('#');
  final List<int> cutIndexes = <int>[
    if (queryIndex >= 0) queryIndex,
    if (fragmentIndex >= 0) fragmentIndex,
  ]..sort();
  if (cutIndexes.isNotEmpty) {
    route = route.substring(0, cutIndexes.first);
  }
  while (route.length > 1 && route.endsWith('/')) {
    route = route.substring(0, route.length - 1);
  }
  return route.isEmpty ? '/' : route;
}

String contentRouteForRelativePath(String relativePath) {
  String route = relativePath
      .replaceAll('\\', '/')
      .replaceFirst(RegExp(r'\.md$'), '');
  if (route == 'index') {
    return '/';
  }
  if (route.endsWith('/index')) {
    route = route.substring(0, route.length - '/index'.length);
  }
  return normalizeInternalRoute('/$route');
}

List<ValidationResult> _validateProductManifest(
  Directory contentDirectory,
  Map<String, ContentDocument> documentsByRoute,
) {
  final List<ValidationResult> results = <ValidationResult>[];
  final Directory gameDirectory = Directory(
    '${contentDirectory.path}/game-servers',
  );
  if (gameDirectory.existsSync()) {
    final List<String> errors = <String>[];
    final List<Directory> directories = gameDirectory
        .listSync(followLinks: false)
        .whereType<Directory>()
        .toList();
    directories.sort(
      (Directory left, Directory right) => left.path.compareTo(right.path),
    );
    for (final Directory directory in directories) {
      final bool containsMarkdown = directory
          .listSync(recursive: true, followLinks: false)
          .whereType<File>()
          .any((File file) => file.path.endsWith('.md'));
      if (!containsMarkdown) {
        continue;
      }
      final String slug = directory.path.split(Platform.pathSeparator).last;
      if (!canonicalGames.containsKey(slug)) {
        errors.add('Unsupported game documentation directory: $slug');
      }
    }
    if (errors.isNotEmpty) {
      results.add(ValidationResult(filePath: 'game-servers/', errors: errors));
    }
  }

  final ContentDocument? planDocument =
      documentsByRoute['/getting-started/choosing-a-plan'];
  if (planDocument == null || planDocument.draft) {
    results.add(
      const ValidationResult(
        filePath: 'getting-started/choosing-a-plan.md',
        errors: <String>['Canonical plan comparison is missing or draft'],
      ),
    );
  } else {
    final List<String> errors = <String>[];
    for (final String row in canonicalPlanTableRows()) {
      if (!planDocument.content.contains(row)) {
        errors.add('Canonical plan row is missing or stale: $row');
      }
    }
    if (errors.isNotEmpty) {
      results.add(
        ValidationResult(filePath: planDocument.relativePath, errors: errors),
      );
    }
  }
  return results;
}

Future<ValidationResult> _validateSearchIndex(
  File file, {
  required Set<String> publishedRoutes,
  required Set<String> draftRoutes,
}) async {
  final List<String> errors = <String>[];
  try {
    final dynamic decoded = jsonDecode(await file.readAsString());
    if (decoded is! Map<String, dynamic>) {
      return ValidationResult(
        filePath: file.path,
        errors: const <String>['Search index root must be an object'],
      );
    }
    if (decoded.containsKey('generated')) {
      errors.add(
        'Search index contains a nondeterministic generated timestamp',
      );
    }
    final dynamic rawEntries = decoded['entries'];
    if (rawEntries is! List<dynamic>) {
      errors.add('Search index entries must be a list');
    } else {
      final List<String> paths = <String>[];
      for (final dynamic rawEntry in rawEntries) {
        if (rawEntry is! Map<String, dynamic>) {
          errors.add('Search index entry must be an object');
          continue;
        }
        final String path = rawEntry['path']?.toString() ?? '';
        paths.add(path);
        if (draftRoutes.contains(path)) {
          errors.add('Draft route leaked into search index: $path');
        }
        if (!publishedRoutes.contains(path)) {
          errors.add('Unknown route leaked into search index: $path');
        }
        errors.addAll(
          validatePublishedContent(
            jsonEncode(rawEntry),
          ).map((String error) => '$path: $error'),
        );
      }
      final List<String> sortedPaths = List<String>.from(paths)..sort();
      if (paths.join('\n') != sortedPaths.join('\n')) {
        errors.add('Search index entries are not sorted by path');
      }
      if (decoded['count'] != rawEntries.length) {
        errors.add('Search index count does not match entry count');
      }
    }
  } on FormatException catch (error) {
    errors.add('Invalid search index JSON: $error');
  }
  return ValidationResult(filePath: file.path, errors: errors);
}

String _relativeContentPath(File file, Directory contentDirectory) {
  final String prefix =
      '${contentDirectory.absolute.path}${Platform.pathSeparator}';
  return file.absolute.path
      .replaceFirst(prefix, '')
      .replaceAll(Platform.pathSeparator, '/');
}

Future<String?> getGitAuthor(String filePath) async {
  try {
    final ProcessResult result = await Process.run('git', <String>[
      'log',
      '--diff-filter=A',
      '--format=%an',
      '--',
      filePath,
    ], workingDirectory: Directory.current.path);
    if (result.exitCode == 0) {
      final String output = result.stdout.toString().trim();
      if (output.isNotEmpty) {
        return output.split('\n').first.trim();
      }
    }

    final ProcessResult fallbackResult = await Process.run('git', <String>[
      'log',
      '-1',
      '--format=%an',
      '--',
      filePath,
    ], workingDirectory: Directory.current.path);
    if (fallbackResult.exitCode == 0) {
      final String output = fallbackResult.stdout.toString().trim();
      if (output.isNotEmpty) {
        return output;
      }
    }
  } on ProcessException {
    return null;
  }
  return null;
}

Future<String> addFrontmatterField(
  File file,
  String field,
  String value,
) async {
  final String content = await file.readAsString();
  final RegExp frontmatterRegex = RegExp(
    r'^(---\s*\n)([\s\S]*?)(\n---)',
    multiLine: true,
  );
  final RegExpMatch? match = frontmatterRegex.firstMatch(content);
  if (match == null) {
    return content;
  }

  final String before = match.group(1) ?? '';
  String yaml = match.group(2) ?? '';
  final String after = match.group(3) ?? '';
  if (!yaml.endsWith('\n')) {
    yaml += '\n';
  }
  yaml += '$field: $value';
  return content.replaceFirst(frontmatterRegex, '$before$yaml$after');
}

void printResult(ValidationResult result, {bool verbose = false}) {
  final String marker = result.errors.isNotEmpty
      ? 'X'
      : result.warnings.isNotEmpty
      ? '!'
      : result.modified
      ? '*'
      : '.';
  stdout.writeln('[$marker] ${result.filePath}');
  for (final String error in result.errors) {
    stdout.writeln('    ERROR: $error');
  }
  for (final String warning in result.warnings) {
    stdout.writeln('    WARN:  $warning');
  }
  if (verbose) {
    for (final String info in result.info) {
      stdout.writeln('    INFO:  $info');
    }
  }
}
