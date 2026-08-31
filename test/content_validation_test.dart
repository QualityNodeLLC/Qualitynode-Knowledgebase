import 'dart:convert';

import 'package:test/test.dart';

import '../tool/content_policy.dart';
import '../tool/generate_search_index.dart';
import '../tool/validate_content.dart';

void main() {
  group('content routes', () {
    test('maps index and article paths to canonical routes', () {
      expect(contentRouteForRelativePath('index.md'), '/');
      expect(contentRouteForRelativePath('billing/index.md'), '/billing');
      expect(
        contentRouteForRelativePath('billing/refunds.md'),
        '/billing/refunds',
      );
    });

    test('normalizes query, fragment, and trailing slash boundaries', () {
      expect(normalizeInternalRoute('/billing/?source=docs'), '/billing');
      expect(
        normalizeInternalRoute('/billing/refunds#request'),
        '/billing/refunds',
      );
      expect(normalizeInternalRoute('/'), '/');
    });

    test('extracts only root-relative markdown links', () {
      const String markdown = '''
[Internal](/billing/refunds)
[With anchor](/billing#help)
[External](https://qualitynode.com)
''';
      expect(extractInternalLinks(markdown), <String>[
        '/billing/refunds',
        '/billing#help',
      ]);
    });
  });

  group('published content policy', () {
    test('accepts canonical support copy', () {
      expect(
        validatePublishedContent(
          'Open the billing portal or email support@qualitynode.net.',
        ),
        isEmpty,
      );
    });

    test('allows TODO markers only on draft pages', () {
      const String todo = '<!-- TODO: add verified screenshot -->';
      expect(validateTodoState(todo, isDraft: true), isEmpty);
      expect(validateTodoState(todo, isDraft: false), isNotEmpty);
    });

    test('rejects placeholder copy on published pages', () {
      expect(
        validatePublishedContent(
          '## Coming Soon\nThis guide is under construction.',
        ),
        isNotEmpty,
      );
    });

    test('rejects unambiguous AI copy and tracking leaks', () {
      const List<String> forbidden = <String>[
        'Great question! I hope this helps.',
        'Experts believe this setting improves performance.',
        'As of my last update, this option was unavailable.',
        "Let's dive in.",
        'See contentReference[oaicite:0] for details.',
        'https://example.com/docs?utm_source=chatgpt.com',
        'Contact [Your Name] before continuing.',
      ];
      for (final String content in forbidden) {
        expect(
          validateCopyHygieneContent(content),
          isNotEmpty,
          reason: content,
        );
      }
    });

    test('applies copy hygiene to drafts and preserves reference syntax', () {
      expect(validateCopyHygieneContent('A robust setup.'), isNotEmpty);
      expect(
        validateCopyHygieneContent(
          '[Your First Server](/getting-started/first-server)',
        ),
        isEmpty,
      );
      expect(
        validateCopyHygieneContent(
          '| Tool | Use |\n| --- | --- |\n| BlueMap | Visual showcase |',
        ),
        isEmpty,
      );
    });

    test(
      'rejects retired tiers, unsupported claims, and wrong support email',
      () {
        const String content = '''
Choose the Agent tier with a 48-hour money-back guarantee.
Email support@qualitynode.com and use 172.18.0.1.
''';
        final List<String> errors = validatePublishedContent(content);
        expect(errors, hasLength(greaterThanOrEqualTo(4)));
      },
    );
  });

  group('canonical product policy', () {
    test('contains current plans and excludes removed game routes', () {
      expect(canonicalPlans.map((CanonicalPlan plan) => plan.name), <String>[
        'Starter',
        'Standard',
        'Performance',
        'Enterprise',
      ]);
      expect(canonicalGames, contains('minecraft'));
      expect(canonicalGames, isNot(contains('dayz')));
      expect(canonicalGames, isNot(contains('forest')));
      expect(canonicalGames, isNot(contains('space-engineers')));
      expect(canonicalGames, isNot(contains('tf2')));
    });

    test('generates the exact canonical plan table boundary rows', () {
      expect(
        canonicalPlanHeader(),
        '| Feature | Starter | Standard | Performance | Enterprise |',
      );
      expect(
        canonicalPlanTableRows().last,
        r'| Price | $4.99/mo | $9.99/mo | $19.99/mo | $39.99/mo |',
      );
    });
  });

  test('search index encoding is deterministic and path sorted', () {
    const List<KnowledgebaseSearchEntry> entries = <KnowledgebaseSearchEntry>[
      KnowledgebaseSearchEntry(
        title: 'Billing',
        path: '/billing',
        category: 'Billing',
      ),
      KnowledgebaseSearchEntry(title: 'Home', path: '/', category: 'General'),
    ];
    final String first = encodeDeterministicSearchIndex(entries);
    final String second = encodeDeterministicSearchIndex(entries);
    final Map<String, dynamic> decoded =
        jsonDecode(first) as Map<String, dynamic>;
    final List<dynamic> decodedEntries = decoded['entries'] as List<dynamic>;

    expect(first, second);
    expect(decoded, isNot(contains('generated')));
    expect(decodedEntries.first, containsPair('path', '/'));
    expect(decodedEntries.last, containsPair('path', '/billing'));
  });
}
