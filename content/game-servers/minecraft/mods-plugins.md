---
title: Uploading Mods and Plugins
description: How to add custom mods and plugins to your Minecraft server.
order: 7
author: Brian Neumann-Fopiano
---

# Uploading Mods and Plugins

This guide explains how to upload mods and plugins to your Minecraft server.

## Understanding the Difference

| Type | Server Software | Folder | Examples |
|------|-----------------|--------|----------|
| **Mods** | Forge, Fabric | `/mods` | Create, Biomes O' Plenty |
| **Plugins** | Paper, Purpur | `/plugins` | EssentialsX, LuckPerms |

> [!IMPORTANT]
> Mods require modded server software (Forge/Fabric). Plugins require plugin-based software (Paper/Purpur). They are not interchangeable.

## Where to Download

### Mods
- [Modrinth](https://modrinth.com/mods) (recommended)
- [CurseForge](https://curseforge.com/minecraft/mc-mods)

### Plugins
- [Modrinth](https://modrinth.com/plugins)
- [SpigotMC](https://spigotmc.org/resources)
- [Hangar](https://hangar.papermc.io) (Paper's official repository)

## Upload Steps

### Step 1: Access the File Manager

1. Go to your control panel and select your server
2. Click **Files** in the sidebar
3. Navigate to the appropriate folder:
   - For mods: `/mods`
   - For plugins: `/plugins`

### Step 2: Upload Your Files

Drag and drop your downloaded `.jar` files into the browser window. The panel displays upload progress automatically.

<!-- TODO: Add screenshot of the file upload interface -->

### Step 3: Restart Your Server

Your server must restart to load new mods or plugins.

### Step 4: Verify Installation

**For plugins:** Run the `plugins` command in your server console to see a list of loaded plugins.

**For mods:** Check your server logs for mod loading messages. Players will need the same mods installed on their clients.

## Plugin Installer

Non-modded servers (Paper, Purpur, etc.) have access to a built-in **Plugin Installer** for one-click plugin installation:

1. Go to your server's control panel
2. Click **Plugins** in the sidebar
3. Browse or search for plugins
4. Click **Install** on your desired plugin

<!-- TODO: Add screenshot of the Plugin Installer -->

> [!NOTE]
> The Plugin Installer is only available for servers running compatible software like Paper or Purpur.

## Compatibility Tips

- **Match versions:** Download mods/plugins for your exact server version
- **Check dependencies:** Some mods/plugins require other mods/plugins to function
- **Read documentation:** Check the mod/plugin page for installation requirements

## Client-Side vs Server-Side

| Type | Client Needed? | Example |
|------|----------------|---------|
| Server-side only | No | LuckPerms, Lithium |
| Client-side only | Yes (client only) | Optifine, shaders |
| Both sides | Yes | Most gameplay mods |

## Troubleshooting

### Plugin shows red in /plugins list

- Missing dependency
- Incompatible server version
- Configuration error (check logs)

### Mod crashes server on startup

- Version mismatch
- Missing required library
- Conflicting with another mod

### Changes not taking effect

- Did you restart the server?
- Is the file in the correct folder?
- Check file extension is `.jar` not `.jar.zip`

## See Also

- [Installing Modpacks](/game-servers/minecraft/modpacks)
- [SFTP File Access](/game-servers/minecraft/sftp)
- [Choosing Server Software](/game-servers/minecraft/server-software)
