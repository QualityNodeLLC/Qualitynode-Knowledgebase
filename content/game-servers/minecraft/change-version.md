---
title: Changing Software or Version
description: How to update or switch your Minecraft server software and version.
order: 21
author: Brian Neumann-Fopiano
---

# Changing Software or Version

Update your Minecraft version or switch between server software options.

## Changing Version or Software

### Step 1: Access the Control Panel

Go to your control panel and select your server.

### Step 2: Open Software Selection

Click the **Software** button in the sidebar to view available options.

### Step 3: Select New Software

Choose your desired server software:
- Paper, Purpur (plugins)
- Fabric, Forge, NeoForge (mods)
- Vanilla (unmodified)

### Step 4: Choose Version

Select the Minecraft version you want to run. Available addons (like Geyser for Bedrock support) will be shown.

### Step 5: Install

Click **Install** at the bottom. Your server will use the new software on its next startup.

## Using a Custom Server Jar

Want to use a custom or unsupported server jar?

1. Open the **Files** tab
2. Upload your custom `.jar` file
3. Rename it to `server.jar`
4. Restart your server

The server will automatically use your custom jar on boot.

## Version Compatibility

> [!IMPORTANT]
> Worlds generated in newer Minecraft versions cannot be loaded by older versions.

### Upgrading (e.g., 1.20 to 1.21)

Generally safe. Minecraft handles world format updates automatically. Create a backup first as a precaution.

### Downgrading (e.g., 1.21 to 1.20)

Requires one of:
- Delete the `world` folder (loses all progress)
- Use [Chunker](https://chunker.app/) to convert world formats

## Switching Software Types

### Plugins to Mods (Paper to Fabric)

1. Plugins won't work on modded servers
2. Download mod equivalents for your plugins
3. Switch software and install mods

### Mods to Plugins (Fabric to Paper)

1. Mods won't work on plugin servers
2. Find plugin alternatives for your mods
3. Switch software and install plugins

### Keeping Your World

World data generally transfers between server software:
- Your builds and terrain are preserved
- Plugin/mod-specific data may not transfer
- Custom dimensions from mods will be lost

## After Switching

1. Verify your server starts correctly
2. Check that plugins/mods load properly
3. Test world functionality
4. Update any custom configurations

## Troubleshooting

### Server won't start after version change

- Check console for error messages
- Mods/plugins may be incompatible with new version
- Update or remove incompatible mods/plugins

### World won't load

- Version downgrade attempted - world is too new
- Corrupted during switch - restore from backup
- Mod-specific world data incompatible

### Missing features after switch

- Some mod/plugin features don't have equivalents
- Check alternative software for similar functionality

## See Also

- [Choosing Server Software](/game-servers/minecraft/server-software)
- [Reset Your World](/game-servers/minecraft/reset-world)
- [Download Your Backup](/game-servers/minecraft/download-backup)
