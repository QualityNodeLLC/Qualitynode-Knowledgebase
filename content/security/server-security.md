---
title: Server Security
description: Best practices for keeping your game server secure.
icon: lock
order: 5
tags: [security, server, best-practices]
---

# Server Security

Keep your game server secure from unauthorized access and exploits.

## Password Protection

### Server Password
Require a password to join your server:

```properties
# Minecraft
white-list=true

# Rust
server.password "YourPassword"

# Valheim
-password "YourPassword"
```

### RCON Password
Use strong RCON passwords:
- At least 16 characters
- Mix of letters, numbers, symbols
- Don't reuse passwords

> [!WARNING]
> Never share your RCON password publicly. It provides full server control.

## Whitelist

Restrict access to approved players:

1. Enable whitelist in server settings
2. Add trusted players to the whitelist
3. Unknown players are blocked

## Firewall Configuration

QualityNode servers include firewall protection:

- Only necessary ports are open
- Game ports are protected
- Management ports are secured

### Default Open Ports

| Service | Port |
|---------|------|
| Game | Varies by game |
| RCON | As configured |
| Query | As configured |

## Keep Software Updated

Regular updates patch security vulnerabilities:

- Update your game server software
- Update mods and plugins
- Remove unused mods/plugins

## Mod Security

Be careful with mods from unknown sources:

- Only use mods from trusted sources
- Check mod reviews and reputation
- Keep mods updated
- Remove mods you don't use

> [!CAUTION]
> Malicious mods can compromise your server. Only install mods from trusted sources.

## Admin Security

- Limit admin/op permissions
- Use permission plugins for fine-grained control
- Don't give admin to players you don't trust
- Log admin actions

## Backup Regularly

Backups protect against:
- Griefing
- Data corruption
- Ransomware
- Accidental deletion

See [Backups](/knowledgebase/server-management/backups) for more information.
