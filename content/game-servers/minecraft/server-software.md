---
title: Choosing Minecraft Server Software
description: Compare Paper, Fabric, Forge, and other server software options to find the best fit for your Minecraft server.
order: 3
author: Brian Neumann-Fopiano
---

# Choosing Minecraft Server Software

QualityNode offers several Minecraft server software options. Compare them by mod support, plugin support, and workload.

## Options

| Software | Best For | Supports |
|----------|----------|----------|
| Paper | Large servers, plugins | Plugins |
| Fabric | Modern modding, performance | Mods |
| Forge/NeoForge | Classic modpacks | Mods |
| Pufferfish/Purpur | High-performance networks | Plugins |
| Vanilla | Pure Minecraft experience | None |

## Paper

Paper is a high-performance fork of Spigot, optimized for plugin-based servers.

**Strengths:**
- Excellent performance, capable of handling dozens to hundreds of players
- Extensive plugin ecosystem via SpigotMC and Modrinth
- Built-in optimizations and anti-cheat features
- Enables Java-Bedrock crossplay with Geyser

**Best for:** Survival servers, minigame networks, and any server using plugins rather than mods.

## Fabric

Fabric is a lightweight modding platform focused on performance and modern Minecraft versions.

**Strengths:**
- Superior performance and stability compared to Forge
- Rapid updates for new Minecraft versions
- Growing mod library on CurseForge and Modrinth
- Optional pre-installed optimization mods

**Best for:** Modern modded servers prioritizing performance, especially with optimization mods like Lithium.

> [!TIP]
> We recommend Fabric over Forge for new modded servers when your desired mods are available for both platforms.

## Forge & NeoForge

Forge is the original modding platform, with NeoForge as its modern successor.

**Strengths:**
- Massive mod library spanning years of development
- Most classic modpacks are built on Forge
- One-click modpack installation from CurseForge

**Considerations:**
- More resource-intensive than Fabric
- Slower to update for new Minecraft versions

**Best for:** Playing established modpacks, using Forge-exclusive mods.

## Pufferfish & Purpur

These are Paper forks with additional performance optimizations and configuration options.

**Strengths:**
- Enhanced performance for large player counts
- More configuration options than Paper
- Can support multiple hundreds of players when optimized

**Best for:** Large networks requiring maximum performance and customization.

## Software to avoid

> [!CAUTION]
> Avoid "hybrid" software like Mohist and Magma that attempt to combine mods and plugins. These often cause stability issues and potential world corruption. Choose either a mod-based or plugin-based platform.

## How to change software

1. Go to your server's control panel
2. Click **Software** in the sidebar
3. Select your desired software and version
4. Choose any available addons
5. Click **Install**

Your server will use the new software on its next startup.

> [!WARNING]
> When downgrading to an older Minecraft version, worlds generated in newer versions won't load. You'll need to delete the world folder or use a tool like Chunker for conversion.

See also: [Changing Software or Version](/game-servers/minecraft/change-version)
