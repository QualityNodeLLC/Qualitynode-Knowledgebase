/// Generate a deterministic search index from published knowledgebase content.
library;

import 'dart:convert';
import 'dart:io';

import 'validate_content.dart';

Future<void> main() async {
  stdout.writeln('Generating search index...');
  final List<ContentDocument> documents = await loadContentDocuments(
    Directory('content'),
  );
  final List<KnowledgebaseSearchEntry> entries = documents
      .where((ContentDocument document) => !document.draft && !document.hidden)
      .map(KnowledgebaseSearchEntry.fromDocument)
      .toList();
  final String json = encodeDeterministicSearchIndex(entries);
  final File file = File('web/search-index.json');
  await file.parent.create(recursive: true);
  await file.writeAsString('$json\n');
  stdout.writeln(
    'Generated web/search-index.json with ${entries.length} published pages',
  );
}

class KnowledgebaseSearchEntry {
  final String title;
  final String path;
  final String category;
  final String? description;
  final List<String> keywords;
  final String? excerpt;
  final String? icon;

  const KnowledgebaseSearchEntry({
    required this.title,
    required this.path,
    required this.category,
    this.description,
    this.keywords = const <String>[],
    this.excerpt,
    this.icon,
  });

  factory KnowledgebaseSearchEntry.fromDocument(ContentDocument document) {
    final String title =
        document.frontmatter['title']?.toString().trim() ??
        _titleFromSlug(document.route.split('/').last);
    final String? description = document.frontmatter['description']
        ?.toString()
        .trim();
    final String? icon = document.frontmatter['icon']?.toString().trim();
    final List<String> tags = _frontmatterStrings(document.frontmatter['tags']);
    final List<String> routeKeywords = document.route
        .split('/')
        .where((String segment) => segment.length > 2)
        .map((String segment) => segment.replaceAll('-', ' '))
        .toList();
    final List<String> keywords = <String>{...tags, ...routeKeywords}.toList()
      ..sort();
    final String excerpt = _contentExcerpt(document.content);

    return KnowledgebaseSearchEntry(
      title: title,
      path: document.route,
      category: _categoryForRoute(document.route),
      description: description == null || description.isEmpty
          ? null
          : description,
      keywords: keywords,
      excerpt: excerpt.isEmpty ? null : excerpt,
      icon: icon == null || icon.isEmpty ? null : icon,
    );
  }

  Map<String, Object> toJson() {
    final Map<String, Object> json = <String, Object>{
      'title': title,
      'path': path,
      'category': category,
      if (keywords.isNotEmpty) 'keywords': keywords,
    };
    if (description != null) {
      json['description'] = description!;
    }
    if (excerpt != null) {
      json['excerpt'] = excerpt!;
    }
    if (icon != null) {
      json['icon'] = icon!;
    }
    return json;
  }
}

String encodeDeterministicSearchIndex(List<KnowledgebaseSearchEntry> entries) {
  final List<KnowledgebaseSearchEntry> sortedEntries =
      List<KnowledgebaseSearchEntry>.from(entries)..sort(
        (KnowledgebaseSearchEntry left, KnowledgebaseSearchEntry right) =>
            left.path.compareTo(right.path),
      );
  final Map<String, Object> data = <String, Object>{
    'version': 1,
    'count': sortedEntries.length,
    'entries': sortedEntries
        .map((KnowledgebaseSearchEntry entry) => entry.toJson())
        .toList(),
  };
  return const JsonEncoder.withIndent('  ').convert(data);
}

List<String> _frontmatterStrings(dynamic value) {
  if (value is Iterable<dynamic>) {
    return value
        .map((dynamic item) => item.toString().trim())
        .where((String item) => item.isNotEmpty)
        .toList();
  }
  return const <String>[];
}

String _categoryForRoute(String route) {
  final List<String> segments = route
      .split('/')
      .where((String segment) => segment.isNotEmpty)
      .toList();
  if (segments.isEmpty) {
    return 'General';
  }
  if (segments.first == 'game-servers' && segments.length >= 2) {
    return _titleFromSlug(segments[1]);
  }
  return _titleFromSlug(segments.first);
}

String _titleFromSlug(String slug) {
  if (slug.trim().isEmpty) {
    return 'General';
  }
  return slug
      .split('-')
      .where((String word) => word.isNotEmpty)
      .map(
        (String word) =>
            '${word.substring(0, 1).toUpperCase()}${word.substring(1)}',
      )
      .join(' ');
}

String _contentExcerpt(String content) {
  String body = content.replaceFirst(
    RegExp(r'^---\s*\n[\s\S]*?\n---\s*', multiLine: true),
    '',
  );
  body = body.replaceAll(RegExp(r'```[\s\S]*?```'), ' ');
  body = body.replaceAll(RegExp(r'<!--([\s\S]*?)-->'), ' ');
  body = body.replaceAllMapped(
    RegExp(r'\[([^\]]+)\]\([^)]+\)'),
    (Match match) => match.group(1) ?? '',
  );
  body = body.replaceAll(RegExp(r'<[^>]+>'), ' ');
  body = body.replaceAll(RegExp(r'[#>*_`|~-]+'), ' ');
  body = body.replaceAll(RegExp(r'\s+'), ' ').trim();
  if (body.length <= 600) {
    return body;
  }
  return '${body.substring(0, 597).trimRight()}...';
}
