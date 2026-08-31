/// The entrypoint for the **server** app (static generation).
library;

import 'package:jaspr/server.dart';
import 'package:arcane_lexicon/arcane_lexicon.dart' hide runApp;
import 'package:arcane_jaspr_neon/arcane_jaspr_neon.dart';

import 'main.server.options.dart';

void main() async {
  Jaspr.initializeApp(options: defaultServerOptions);

  runApp(
    await KnowledgeBaseApp.create(
      config: const SiteConfig(
        name: 'QualityNode KnowledgeBase',
        description: 'Game server hosting documentation and guides',
        contentDirectory: 'content',
        githubUrl:
            'https://github.com/QualityNodeLLC/Qualitynode-Knowledgebase',
        showEditLink: true,
        editBranch: 'main',
        defaultTheme: KBThemeMode.system,
        headerLinks: [
          NavLink(
            label: 'Website',
            href: 'https://qualitynode.com',
            external: true,
          ),
          NavLink(
            label: 'Discord',
            href: 'https://discord.qualitynode.com',
            external: true,
          ),
        ],
        footerText: 'Built with Arcane Lexicon',
        sidebarFooter: 'QualityNode',
        sidebarFooterUrl: 'https://qualitynode.com',
      ),
      stylesheet: const NeonStylesheet(),
      generateSearchIndex: false,
    ),
  );
}
