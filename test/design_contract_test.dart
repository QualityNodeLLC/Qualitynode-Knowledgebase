import 'dart:io';

import 'package:test/test.dart';

void main() {
  group('QualityNode knowledgebase design contract', () {
    late String css;

    setUpAll(() {
      css = File('web/styles.css').readAsStringSync();
    });

    test('uses only local font assets', () {
      expect(css, contains("font-family: 'Akzidenz Grotesk Pro'"));
      expect(css, contains("font-family: 'ITC Avant Garde'"));
      expect(css, contains("font-family: 'Hack'"));
      expect(css, isNot(contains(RegExp(r'https?://'))));

      final RegExp fontUrlPattern = RegExp(
        r'''url\(\s*["']?/assets/fonts/([^"')]+)["']?\s*\)''',
        caseSensitive: false,
      );
      final List<RegExpMatch> fontUrls = fontUrlPattern
          .allMatches(css)
          .toList();
      expect(fontUrls, isNotEmpty);
      for (final RegExpMatch match in fontUrls) {
        final String relativePath = match.group(1) ?? '';
        expect(
          File('web/assets/fonts/$relativePath').existsSync(),
          isTrue,
          reason: 'Missing local font asset: $relativePath',
        );
      }
    });

    test('application sources never opt into remote font loading', () {
      final String sources = <String>[
        File('lib/main.server.dart').readAsStringSync(),
        File('web/styles.css').readAsStringSync(),
        File('pubspec.yaml').readAsStringSync(),
      ].join('\n');

      expect(
        sources,
        isNot(
          contains(
            RegExp(
              r'''(?:@import\s+(?:url\()?|@font-face[\s\S]*?url\()\s*["']?https?://''',
              caseSensitive: false,
            ),
          ),
        ),
      );
    });

    test('copy hygiene runs before draft publication checks', () {
      final String validator = File(
        'tool/validate_content.dart',
      ).readAsStringSync();
      final int copyGate = validator.indexOf(
        'errors.addAll(validateCopyHygieneContent(document.content));',
      );
      final int publishedGate = validator.indexOf('if (!document.draft) {');

      expect(copyGate, greaterThanOrEqualTo(0));
      expect(copyGate, lessThan(publishedGate));
    });

    test('does not restore the retired surface effects', () {
      for (final Pattern forbidden in <Pattern>[
        RegExp(r'(?:repeating-)?(?:linear|radial|conic)-gradient\('),
        RegExp(r'backdrop-filter\s*:'),
        RegExp(r'box-shadow\s*:'),
        RegExp(r'border-radius\s*:\s*(?:999\d*px|50%|var\([^)]*full)'),
        RegExp(r'border-(?:left|right)(?:\s*:|-color\s*:|-width\s*:)'),
      ]) {
        expect(css, isNot(contains(forbidden)));
      }
    });

    test('leaves Lexicon components under the canonical theme', () {
      for (final String selector in <String>[
        '.kb-card',
        '.kb-tile',
        '.kb-callout',
        '.kb-badge',
        '.kb-tag',
        '.kb-panel',
      ]) {
        expect(css, isNot(contains(selector)));
      }
    });

    test('browser policy enforces icon and pseudo-accent limits', () {
      final String browserPolicy = File(
        'test/browser/knowledgebase_design_policy.browser.js',
      ).readAsStringSync();
      final String browserRunner = File(
        'test/browser/run_knowledgebase_policy.mjs',
      ).readAsStringSync();

      expect(browserPolicy, contains("querySelectorAll('i, svg, img')"));
      expect(browserPolicy, contains('visibleIcons.length > 1'));
      expect(browserPolicy, contains("'summary'"));
      expect(browserPolicy, contains("['::before', '::after']"));
      expect(browserPolicy, contains('pseudoStyle.maskImage'));
      expect(browserPolicy, contains('pseudoStyle.borderImageSource'));
      expect(browserPolicy, contains(r'painted ${pseudo} accent'));
      expect(browserPolicy, contains("'[data-arcane-surface]'"));
      expect(browserPolicy, contains('controls.includes(element) ? 6 : 8'));
      expect(browserPolicy, contains('remoteInlineFont'));
      expect(browserPolicy, contains("document.querySelectorAll('style')"));
      expect(browserPolicy, contains("input.getAttribute('aria-controls')"));
      expect(browserPolicy, contains('sidebar expanded state is out of sync'));
      expect(browserRunner, contains('const widths = [375, 768, 1440]'));
      expect(browserRunner, contains("'[data-kb-sidebar-toggle]:visible'"));
      expect(browserRunner, contains("'[data-kb-search-input]:visible'"));
      expect(browserRunner, contains("'[data-kb-theme-toggle]:visible'"));
      expect(
        RegExp(r'for \(const width of widths\)').allMatches(browserRunner),
        hasLength(2),
      );
      expect(browserRunner, contains('desktop sidebar is not visible'));
      expect(browserRunner, contains('light and dark theme states'));
      expect(browserRunner, contains('route identity mismatch'));
      expect(browserRunner, contains("page.locator('article h1')"));
      expect(browserRunner, contains('Forbidden nested surface'));
      expect(browserRunner, contains('mutation self-test did not reject'));
    });

    test('deploy gates the hosting output with the browser policy', () {
      final String workflow = File(
        '.github/workflows/main.yml',
      ).readAsStringSync();
      final String browserPackage = File(
        'test/browser/package.json',
      ).readAsStringSync();
      final String browserLock = File(
        'test/browser/package-lock.json',
      ).readAsStringSync();

      final int buildStep = workflow.indexOf('- name: Build Jaspr app');
      final int browserStep = workflow.indexOf(
        '- name: Check Knowledgebase browser design policy',
      );
      final int deployStep = workflow.indexOf(
        '- name: Deploy to Firebase Hosting',
      );

      expect(buildStep, greaterThanOrEqualTo(0));
      expect(browserStep, greaterThan(buildStep));
      expect(deployStep, greaterThan(browserStep));
      expect(workflow, contains('npm ci'));
      expect(workflow, contains('playwright install --with-deps chromium'));
      expect(workflow, contains('trap cleanup EXIT'));
      expect(workflow, contains('run design-policy'));
      expect(workflow, contains('edd4d7f45dcefe647f0792902acc1808cb47477b'));
      expect(workflow, contains('2c243c21aeac2903118084952217bc1f4f675c49'));
      expect(browserPackage, contains('"playwright": "1.62.1"'));
      expect(browserPackage, contains('"serve": "14.2.6"'));
      expect(
        browserPackage,
        contains('"serve-build": "serve ../../build/jaspr --no-clipboard"'),
      );
      expect(browserPackage, isNot(contains('serve -s ../../build/jaspr')));
      expect(browserLock, contains('"lockfileVersion": 3'));
    });
  });
}
