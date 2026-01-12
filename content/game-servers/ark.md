---
title: ARK Server Setup
description: Complete guide to running an ARK: Survival Evolved server.
icon: egg
order: 4
tags: [ark, survival, dinosaurs]
---

# ARK: Survival Evolved Server Setup

Host your own ARK server with custom settings, mods, and maps.

## Quick Setup

1. Create a new server and select **ARK: Survival Evolved**
2. Choose your map (The Island, Ragnarok, etc.)
3. Configure basic settings
4. Allow time for initial download (~80GB)

> [!NOTE]
> ARK servers require significant resources. We recommend the Director or Astral plan for optimal performance.

## Server Configuration

Edit `GameUserSettings.ini` to customize gameplay:

```ini
[ServerSettings]
ServerPassword=
ServerAdminPassword=YourAdminPassword
MaxPlayers=70
DifficultyOffset=1.0
TamingSpeedMultiplier=3.0
HarvestAmountMultiplier=2.0
XPMultiplier=2.0
```

## Map Options

| Map | Size | Description |
|-----|------|-------------|
| The Island | Medium | Original map |
| Ragnarok | Large | Popular free DLC |
| Valguero | Large | Free expansion |
| Crystal Isles | Large | Crystal-themed |
| Fjordur | Large | Norse-inspired |

## Installing Mods

1. Find mods on the [Steam Workshop](https://steamcommunity.com/app/346110/workshop/)
2. Copy the Mod ID from the URL
3. Add to your server's mod list in the control panel
4. Restart and wait for mod download

### Popular Mods

- **Structures Plus (S+)** - Enhanced building
- **Awesome SpyGlass** - Creature information
- **Super Spyglass** - Detailed dino stats
- **Dino Storage v2** - Pokeball-style storage

## Cluster Setup

Run multiple maps in a cluster:

1. Create servers for each map
2. Use the same cluster ID across all servers
3. Enable cross-ARK transfers
4. Players can transfer between maps via obelisks

## Recommended Plans

| Server Type | Recommended Plan |
|-------------|-----------------|
| Small tribe (10 players) | Director |
| Medium server (30 players) | Astral |
| Cluster (multiple maps) | Multiple Astral |
