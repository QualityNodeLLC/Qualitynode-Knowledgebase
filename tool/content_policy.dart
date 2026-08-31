library;

/// Canonical product facts mirrored from QualityNode-web.
///
/// Keep this file synchronized with:
/// - `qualitynode_web/lib/config/games_catalog.dart`
/// - `qualitynode_web/lib/config/pricing.dart`
const String canonicalSupportEmail = 'support@qualitynode.net';

class CanonicalPlan {
  final String id;
  final String name;
  final String price;
  final String ram;
  final String cpu;
  final String storage;
  final String players;
  final List<String> features;

  const CanonicalPlan({
    required this.id,
    required this.name,
    required this.price,
    required this.ram,
    required this.cpu,
    required this.storage,
    required this.players,
    required this.features,
  });
}

const List<CanonicalPlan> canonicalPlans = <CanonicalPlan>[
  CanonicalPlan(
    id: 'starter',
    name: 'Starter',
    price: r'$4.99/mo',
    ram: '2 GB',
    cpu: '1 vCPU',
    storage: '15 GB NVMe',
    players: '~10',
    features: <String>[
      'Supported Game Catalog',
      'DDoS Protection',
      'Backup Controls',
      'Pterodactyl Panel',
    ],
  ),
  CanonicalPlan(
    id: 'standard',
    name: 'Standard',
    price: r'$9.99/mo',
    ram: '4 GB',
    cpu: '2 vCPU',
    storage: '30 GB NVMe',
    players: '~25',
    features: <String>[
      'Supported Game Catalog',
      'DDoS Protection',
      'Backup Controls',
      'Pterodactyl Panel',
      'Custom Subdomain',
    ],
  ),
  CanonicalPlan(
    id: 'performance',
    name: 'Performance',
    price: r'$19.99/mo',
    ram: '8 GB',
    cpu: '4 vCPU',
    storage: '60 GB NVMe',
    players: '~50',
    features: <String>[
      'Supported Game Catalog',
      'DDoS Protection',
      'Backup Controls',
      'Pterodactyl Panel',
      'Custom Domain',
      'MySQL Database',
    ],
  ),
  CanonicalPlan(
    id: 'enterprise',
    name: 'Enterprise',
    price: r'$39.99/mo',
    ram: '16 GB',
    cpu: '8 vCPU',
    storage: '120 GB NVMe',
    players: '100+',
    features: <String>[
      'Supported Game Catalog',
      'DDoS Protection',
      'Backup Controls',
      'Pterodactyl Panel',
      'Custom Domain',
      'Unlimited MySQL',
      'Dedicated IP',
      'Priority Support',
    ],
  ),
];

const Map<String, String> canonicalGames = <String, String>{
  'hytale': 'Hytale',
  'minecraft': 'Minecraft',
  'terraria': 'Terraria',
  'valheim': 'Valheim',
  'enshrouded': 'Enshrouded',
  'factorio': 'Factorio',
  'ark': 'ARK: Survival Evolved',
  'ark-ascended': 'ARK: Survival Ascended',
  'rust': 'Rust',
  '7days': '7 Days to Die',
  'conan': 'Conan Exiles',
  'vrising': 'V Rising',
  'palworld': 'Palworld',
  'unturned': 'Unturned',
  'projectzomboid': 'Project Zomboid',
  'cs2': 'Counter-Strike 2',
  'risingstorm2': 'Rising Storm 2: Vietnam',
  'quakelive': 'Quake Live',
  'gmod': "Garry's Mod",
  'satisfactory': 'Satisfactory',
  'farmingsim': 'Farming Simulator',
};

const List<ForbiddenContentRule>
forbiddenAllContentCopyRules = <ForbiddenContentRule>[
  ForbiddenContentRule(
    r'''\b(?:delv(?:e|es|ed|ing)|tapestr(?:y|ies)|paradigms?|embark(?:s|ed|ing)?|beacons?|robust|comprehensive|cutting-edge|leverag(?:e|es|ed|ing)|pivotal|underscor(?:e|es|ed|ing)|meticulous(?:ly)?|seamless(?:ly)?|game-chang(?:er|ing)|watershed moment|nestled|vibrant|thriv(?:e|es|ed|ing)|showcas(?:e|es|ed|ing)|deep dives?|unpack(?:s|ed|ing)?|bustling|intricac(?:y|ies)|intricate|ever-evolving|daunting|holistic(?:ally)?|actionable|impactful|learnings?|synerg(?:y|ies)|interplay|genuinely|symphon(?:y|ies))\b''',
    'unambiguous AI vocabulary',
  ),
  ForbiddenContentRule(
    r'''\b(?:I hope this helps|Great question|Feel free to reach out|Let me know if you need anything else)\b''',
    'chatbot copy artifact',
  ),
  ForbiddenContentRule(
    r'''\b(?:Experts believe|Studies show|Research suggests|Industry leaders agree)\b''',
    'vague unsourced attribution',
  ),
  ForbiddenContentRule(
    r'''\b(?:As of my last update|I don.t have access to real-time data|specific details are limited based on available information)\b''',
    'model limitation disclaimer',
  ),
  ForbiddenContentRule(
    r'''\b(?:Let.s (?:dive in|explore|take a look|break (?:this|it) down)|In conclusion|The future looks bright|Only time will tell)\b''',
    'formulaic AI copy',
  ),
  ForbiddenContentRule(
    r'''(?:cite(?:turn)?\d*(?:search|news|open)\d+|contentReference\[oaicite|oai_citation|\[attached_file:\d+\]|grok_card)''',
    'AI citation markup leak',
  ),
  ForbiddenContentRule(
    r'''(?:utm_source=(?:chatgpt(?:\.com)?|copilot(?:\.com)?|openai|claude\.ai|perplexity\.ai)|referrer=grok\.com)''',
    'AI tracking parameter',
  ),
  ForbiddenContentRule(
    r'''\[(?:Your|Insert|Add|Enter|Describe|Specify|Choose)\s+[^\]]+\](?!\()|\b\d{4}-XX-XX\b''',
    'unfilled public placeholder',
  ),
];

class ForbiddenContentRule {
  final String pattern;
  final String description;
  final bool caseSensitive;

  const ForbiddenContentRule(
    this.pattern,
    this.description, {
    this.caseSensitive = false,
  });
}

const List<ForbiddenContentRule>
forbiddenPublishedContentRules = <ForbiddenContentRule>[
  ForbiddenContentRule(
    r'\b(?:Threshold|Agent|Director|Astral)\b',
    'retired plan tier',
    caseSensitive: true,
  ),
  ForbiddenContentRule(
    r'\b(?:Visa|Mastercard|American Express|Discover|PayPal|Apple Pay|Google Pay|Bitcoin|Ethereum|USDC|Coinbase Commerce)\b',
    'unsupported payment-method claim',
  ),
  ForbiddenContentRule(
    r'\b(?:PCI DSS|SSL/TLS)\b|never store full card numbers',
    'unsupported payment-security claim',
  ),
  ForbiddenContentRule(
    r'48[- ]hour|money-back guarantee|no questions asked|annual subscriptions after 7 days',
    'unsupported refund policy',
  ),
  ForbiddenContentRule(
    r'5-10 business days|3-5 business days|24-48 hours|processing time depends on your payment provider',
    'unsupported refund timing',
  ),
  ForbiddenContentRule(
    r'17%|price lock guarantee|two months free|automatically renew|email reminders before renewal',
    'unsupported subscription policy',
  ),
  ForbiddenContentRule(
    r'retry the payment after|services may be suspended after|consolidated invoices|VAT/Tax ID',
    'unsupported invoice policy',
  ),
  ForbiddenContentRule(
    r'support@qualitynode\.com|\*\*Response Time\*\*',
    'noncanonical support identity or response-time promise',
  ),
  ForbiddenContentRule(r'And many more', 'open-ended product catalog claim'),
  ForbiddenContentRule(
    r'free subdomains?|172\.18\.0\.1|quick-copy|it.s what QualityNode runs',
    'unsupported infrastructure or product-control claim',
  ),
  ForbiddenContentRule(
    r'\bUnder Construction\b|##\s+Coming Soon\b',
    'unfinished public documentation',
  ),
];

String canonicalPlanHeader() {
  final String names = canonicalPlans
      .map((CanonicalPlan plan) => plan.name)
      .join(' | ');
  return '| Feature | $names |';
}

String canonicalPlanRow(
  String label,
  String Function(CanonicalPlan plan) value,
) {
  final String values = canonicalPlans.map(value).join(' | ');
  return '| $label | $values |';
}

List<String> canonicalPlanTableRows() => <String>[
  canonicalPlanHeader(),
  canonicalPlanRow('RAM', (CanonicalPlan plan) => plan.ram),
  canonicalPlanRow('CPU', (CanonicalPlan plan) => plan.cpu),
  canonicalPlanRow('Storage', (CanonicalPlan plan) => plan.storage),
  canonicalPlanRow('Player guidance', (CanonicalPlan plan) => plan.players),
  canonicalPlanRow('Price', (CanonicalPlan plan) => plan.price),
];
