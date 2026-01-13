---
title: Getting Started with Your Minecraft Server
description: Essential first steps for setting up your new Minecraft server on QualityNode.
order: 2
author: Brian Neumann-Fopiano
---

# Getting Started with Your Minecraft Server

This guide covers the essential setup steps for your new QualityNode Minecraft server.

## 1. Software and Modpack Installation

QualityNode allows you to choose from various server versions and modpacks. You have two main options:

**Pre-made Modpacks**: Install modpacks from CurseForge or Modrinth through the **Modpacks** tab. You can browse popular packs or search for specific ones.

**Custom Server Software**: Use the **Software** tab to install your preferred server software:
- Paper (recommended for plugins)
- Fabric (recommended for mods)
- Forge/NeoForge (extensive mod support)
- Vanilla (no modifications)

<!-- TODO: Add screenshot of the Software tab -->

## 2. Server Configuration and Whitelist

Your server comes with a username-based whitelist enabled by default. This prevents random players from joining until you're ready.

### Essential Console Commands

Use these commands in your server console (no forward slash needed):

```
whitelist add <player>
```

Replace `<player>` with the Minecraft username. Additional useful commands:

| Command | Description |
|---------|-------------|
| `op <player>` | Grant operator permissions |
| `deop <player>` | Remove operator status |
| `whitelist remove <player>` | Remove from allowlist |
| `whitelist list` | View all whitelisted players |
| `whitelist off` | Disable the whitelist |

> [!NOTE]
> Console commands don't require a forward slash prefix. Only use `/` when typing commands in-game.

You can also configure your server through the `server.properties` file in the **Files** tab. See our [server.properties guide](/game-servers/minecraft/server-properties) for details.

## 3. Joining Your Server

Find your connection details in the top-right corner of your console:

1. Copy the **IP address** and **port** displayed
2. Open Minecraft and go to **Multiplayer** > **Add Server**
3. Enter the IP and port (format: `123.45.67.89:25565`)
4. Make sure you're running the same Minecraft version as your server

<!-- TODO: Add screenshot showing where to find IP and port -->

### Custom Subdomain

Want a friendlier address like `myserver.minecraft.horse`? Create a custom subdomain through the **Network** tab in your control panel. See our [custom domain guide](/game-servers/minecraft/custom-domain) for more options.

## Next Steps

Now that your server is running, explore these guides:

- [Choosing Server Software](/game-servers/minecraft/server-software) - Find the right software for your needs
- [Installing Modpacks](/game-servers/minecraft/modpacks) - Add modded content
- [Configuring server.properties](/game-servers/minecraft/server-properties) - Fine-tune your server
- [Automatic Backups](/game-servers/minecraft/automatic-backups) - Protect your world data
