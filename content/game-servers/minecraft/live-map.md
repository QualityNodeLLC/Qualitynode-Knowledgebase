---
title: Live Server Maps
description: Add a web-based map viewer for your Minecraft world.
order: 23
author: Brian Neumann-Fopiano
---

# Live Server Maps

Display your Minecraft world on a web-accessible map showing terrain, structures, and player locations in real-time.

## Map Options Comparison

| Plugin | Style | Performance | Best For |
|--------|-------|-------------|----------|
| **Pl3xMap** | 2D top-down | Low impact | General use |
| **Dynmap** | 2D/Isometric | High impact | Classic look |
| **BlueMap** | 3D explorable | Very high | Visual showcase |

## Pl3xMap (Recommended)

A modern, lightweight map with minimal performance impact.

**Features:**
- Regular updates
- Fast rendering
- Multiple addon integrations
- Low server overhead

[Download on Modrinth](https://modrinth.com/plugin/pl3xmap)

## Dynmap

The classic Minecraft mapping solution with 2D and isometric views.

**Features:**
- Time-tested reliability
- Isometric (angled) view option
- Extensive customization

**Considerations:**
- Requires significant storage
- Long initial render time
- Higher performance impact

[Download on Modrinth](https://modrinth.com/plugin/dynmap)

## BlueMap

Creates stunning 3D maps viewable in a web browser.

**Features:**
- Full 3D exploration
- Beautiful visual quality
- Free-camera navigation

**Considerations:**
- Very performance-intensive
- High storage requirements
- Long render times

[Download on Modrinth](https://modrinth.com/plugin/bluemap)

## Installation Steps

### Step 1: Download Your Choice

Download the appropriate version for your server software (Paper, Fabric, etc.) from Modrinth.

### Step 2: Upload to Server

1. Go to your control panel
2. Click **Files** in the sidebar
3. Navigate to `/mods` or `/plugins`
4. Upload the downloaded file

### Step 3: Initial Restart

Restart your server to generate configuration files.

### Step 4: Create a Web Port

1. Click **Network** in the sidebar
2. Click **Create Port**
3. Copy the port number

### Step 5: Configure the Port

1. Open the map's configuration file:
   - Pl3xMap: `plugins/Pl3xMap/config.yml`
   - Dynmap: `plugins/dynmap/configuration.txt`
   - BlueMap: `config/bluemap/webserver.conf`

2. Update the web server port setting with your new port

3. Save the file

### Step 6: Final Restart

Restart your server to apply the configuration.

### Step 7: Access Your Map

Open a web browser and navigate to:
```
http://<your-server-ip>:<map-port>
```

<!-- TODO: Add example screenshot of a live map -->

## Initial Rendering

By default, maps only show areas that players have explored. To render the entire world:

### Pre-generate First

Use [Chunky](/game-servers/minecraft/chunky) to generate terrain before rendering the map.

### Full Render Commands

**Pl3xMap:**
```
pl3xmap fullrender world
```

**Dynmap:**
```
dynmap fullrender world
```

**BlueMap:**
```
bluemap render
```

> [!WARNING]
> Full renders can take many hours for large worlds and consume significant resources during rendering.

## Storage Considerations

Map tiles consume disk space:

| Map Size | Approximate Storage |
|----------|---------------------|
| Small (5k radius) | 500 MB - 2 GB |
| Medium (10k radius) | 2 - 8 GB |
| Large (20k+ radius) | 10+ GB |

Monitor your disk usage after enabling maps.

## See Also

- [Pre-generate with Chunky](/game-servers/minecraft/chunky)
- [Uploading Mods and Plugins](/game-servers/minecraft/mods-plugins)
