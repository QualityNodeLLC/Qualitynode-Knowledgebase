---
title: Mods and Plugins
description: How to install and manage mods and plugins on your game server.
icon: puzzle
order: 4
tags: [mods, plugins, customization]
---

# Mods and Plugins

Customize your game server with mods and plugins.

## Understanding the Difference

### Mods
- Modify the game itself
- Require matching versions on client and server
- Examples: Forge mods, Fabric mods, Workshop mods

### Plugins
- Server-side only modifications
- Don't require client installation
- Examples: Spigot plugins, Oxide plugins

## Installing via Mod Manager

Many games support one-click mod installation:

1. Go to **Mods** in your control panel
2. Browse available mods
3. Click **Install** on desired mods
4. Restart your server

## Manual Installation

For mods not in the manager:

1. Download the mod file
2. Go to **Files** in your control panel
3. Navigate to the mods/plugins folder:
   - Minecraft: `/plugins` or `/mods`
   - Rust: `/oxide/plugins`
   - ARK: Use Workshop ID in settings
4. Upload the file
5. Restart your server

## Mod Compatibility

> [!CAUTION]
> Always check mod compatibility before installing. Incompatible mods can cause crashes or data corruption.

### Compatibility Checklist

- [ ] Mod version matches game version
- [ ] Mod is compatible with your server software
- [ ] No conflicting mods installed
- [ ] Required dependencies installed

## Updating Mods

1. Create a backup first
2. Download the new mod version
3. Replace the old file in your mods folder
4. Restart your server
5. Test that everything works

## Troubleshooting

### Server Won't Start
- Check server logs for errors
- Try removing recently added mods
- Verify mod compatibility

### Mod Not Working
- Ensure correct installation location
- Check for missing dependencies
- Verify permissions/configuration
