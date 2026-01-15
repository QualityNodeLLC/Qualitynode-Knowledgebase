import 'dart:io';

/// Swaps local path dependencies to git dependencies in pubspec.yaml.
///
/// This is used before git commits to ensure the repo uses remote dependencies
/// that will work for anyone cloning the project.
///
/// Usage:
///   dart run tool/swap_dependencies.dart         # Swap to git deps
///   dart run tool/swap_dependencies.dart --local # Swap to local deps

const Map<String, DependencyInfo> dependencies = {
  'arcane_jaspr': DependencyInfo(
    localPath: '/Users/brianfopiano/Developer/RemoteGit/ArcaneArts/arcane_jaspr',
    gitUrl: 'https://github.com/ArcaneArts/arcane_jaspr',
    gitRef: 'master',
  ),
  'arcane_inkwell': DependencyInfo(
    localPath: '/Users/brianfopiano/Developer/RemoteGit/ArcaneArts/arcane_inkwell',
    gitUrl: 'https://github.com/ArcaneArts/arcane_inkwell',
    gitRef: 'master',
  ),
};

class DependencyInfo {
  final String localPath;
  final String gitUrl;
  final String gitRef;

  const DependencyInfo({
    required this.localPath,
    required this.gitUrl,
    required this.gitRef,
  });

  String get localYaml => '''
    path: $localPath''';

  String get gitYaml => '''
    git:
      url: $gitUrl
      ref: $gitRef''';
}

void main(List<String> args) {
  final bool toLocal = args.contains('--local');
  final File pubspecFile = File('pubspec.yaml');

  if (!pubspecFile.existsSync()) {
    stderr.writeln('Error: pubspec.yaml not found in current directory');
    exit(1);
  }

  String content = pubspecFile.readAsStringSync();
  String originalContent = content;

  for (final MapEntry<String, DependencyInfo> entry in dependencies.entries) {
    final String name = entry.key;
    final DependencyInfo info = entry.value;

    if (toLocal) {
      // Replace git dependency with local path
      final RegExp gitPattern = RegExp(
        r'(\s+)' + RegExp.escape(name) + r':\s*\n\s+git:\s*\n\s+url:[^\n]+\n\s+ref:[^\n]+',
        multiLine: true,
      );
      content = content.replaceAllMapped(gitPattern, (Match match) {
        final String indent = match.group(1)!;
        return '$indent$name:${info.localYaml}';
      });
    } else {
      // Replace local path with git dependency
      final RegExp localPattern = RegExp(
        r'(\s+)' + RegExp.escape(name) + r':\s*\n\s+path:[^\n]+',
        multiLine: true,
      );
      content = content.replaceAllMapped(localPattern, (Match match) {
        final String indent = match.group(1)!;
        return '$indent$name:${info.gitYaml}';
      });
    }
  }

  if (content != originalContent) {
    pubspecFile.writeAsStringSync(content);
    final String mode = toLocal ? 'local path' : 'git';
    print('Swapped dependencies to $mode');
  } else {
    final String mode = toLocal ? 'local' : 'git';
    print('Dependencies already using $mode format (no changes)');
  }
}
