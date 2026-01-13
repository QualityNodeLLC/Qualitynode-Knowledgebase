/// The entrypoint for the **server** app (static generation).
library;

import 'package:jaspr/server.dart';
import 'package:arcane_inkwell/arcane_inkwell.dart' hide runApp;

import 'main.server.options.dart';

void main() async {
  Jaspr.initializeApp(options: defaultServerOptions);

  runApp(
    await KnowledgeBaseApp.create( 
      config: const SiteConfig(
        name: 'QualityNode KnowledgeBase',
        description: 'Game server hosting documentation and guides',
        contentDirectory: 'content',
        githubUrl: 'https://github.com/QualityNodeLLC/Qualitynode-Knowledgebase',
        showEditLink: true,
        editBranch: 'main',
        headerLinks: [
          NavLink(label: 'Docs', href: '/'),
          NavLink(
              label: 'Website',
              href: 'https://qualitynode.net',
              external: true),
          NavLink(
              label: 'Discord',
              href: 'https://discord.gg/Z2ePfBnt',
              external: true),
        ],
        footerText: 'Built with Arcane Inkwell',
        sidebarFooter: 'QualityNode',
        sidebarFooterUrl: 'https://qualitynode.net',
      ),
      stylesheet: const CodexStylesheet(theme: CodexTheme.green)
      // stylesheet: const ShadcnStylesheet(theme: ShadcnTheme.midnight),
    ),
  );
}
