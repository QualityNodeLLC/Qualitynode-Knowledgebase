---
title: Minecraft Server Setup
description: Complete guide to setting up and configuring your Minecraft server.
icon: box
order: 2
tags: [minecraft, java, bedrock, popular]
---

# Minecraft Server Setup

QualityNode supports both Java Edition and Bedrock Edition Minecraft servers.

## Choosing Your Edition

### Java Edition
- Cross-platform for PC, Mac, and Linux
- Extensive mod support (Forge, Fabric)
- Plugin support (Spigot, Paper)

### Bedrock Edition
- Cross-play between Windows 10, Xbox, PlayStation, Switch, and mobile
- Limited mod support
- Better performance on lower-end hardware

## Quick Setup

1. Create a new server and select **Minecraft**
2. Choose your edition (Java or Bedrock)
3. Select your server software:
   - **Vanilla** - Official Minecraft server
   - **Paper** - Optimized with plugin support
   - **Forge** - For mod support
   - **Fabric** - Lightweight modding

## Server Configuration

Edit `server.properties` to customize your server:

```properties
# Basic Settings
server-name=My Server
motd=Welcome to my QualityNode server!
max-players=20
difficulty=normal
gamemode=survival

# Performance
view-distance=10
simulation-distance=8

# Security
white-list=false
enforce-whitelist=false
online-mode=true
```

## Installing Plugins (Paper/Spigot)

1. Go to **Files** in your control panel
2. Navigate to the `plugins` folder
3. Upload your `.jar` plugin files
4. Restart your server

## Installing Mods (Forge/Fabric)

1. Go to **Files** in your control panel
2. Navigate to the `mods` folder
3. Upload your mod files
4. Restart your server

> [!WARNING]
> Ensure all mods are compatible with your server version. Incompatible mods can cause crashes.

## Recommended Plans

| Server Type | Recommended Plan |
|-------------|-----------------|
| Small vanilla (1-10 players) | Threshold |
| Modded (10-25 players) | Agent |
| Large modded (25-50 players) | Director |
| Network/BungeeCord | Astral |
