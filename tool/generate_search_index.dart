/// Script to generate search-index.json from knowledgebase content.
///
/// Run this before `jaspr build` to generate the search index:
///   dart run tool/generate_search_index.dart
///
/// The generated file will be in web/search-index.json and will be
/// included in the build output.
library;

import 'dart:io' as io;

// Use direct package imports (these are all exported from arcane_lexicon)
import 'package:arcane_lexicon/arcane_lexicon.dart';

void main() async {
  print('Generating search index...');

  // Build the navigation manifest from content
  const config = SiteConfig(
    name: 'QualityNode KnowledgeBase',
    contentDirectory: 'content',
  );

  final navBuilder = NavBuilder(
    contentDirectory: config.contentDirectory,
    baseUrl: config.baseUrl,
  );

  final manifest = await navBuilder.build();

  // Generate search index
  final generator = SearchIndexGenerator(
    config: config,
    manifest: manifest,
  );

  final json = generator.generate(pretty: true);

  // Write to web directory
  final file = io.File('web/search-index.json');
  await file.writeAsString(json);

  print('Generated web/search-index.json with ${manifest.totalPages} pages');
}
