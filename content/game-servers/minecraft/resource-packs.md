---
title: Adding Resource Packs
description: How to set up a server resource pack that automatically downloads for players.
order: 10
author: Brian Neumann-Fopiano
---

# Adding Resource Packs

A server resource pack automatically downloads custom textures, sounds, and models when players join your server.

## Overview

Unlike mods, resource packs are client-side only and change the game's appearance without modifying gameplay. Your server hosts the download link, and players receive the pack automatically on join.

## Step 1: Obtain a Resource Pack

Download a `.zip` resource pack file from:
- [Modrinth](https://modrinth.com/resourcepacks)
- [CurseForge](https://curseforge.com/minecraft/texture-packs)
- [Planet Minecraft](https://planetminecraft.com/texture-packs)

Or use your own custom pack.

## Step 2: Host the Pack

Resource packs must be hosted on a direct download URL. We recommend [MCPacks](https://mc-packs.net/), a free hosting service:

1. Go to [mc-packs.net](https://mc-packs.net/)
2. Upload your resource pack `.zip` file
3. Copy both the **download URL** and **SHA-1 hash**

<!-- TODO: Add screenshot of MCPacks interface -->

## Step 3: Configure server.properties

1. Go to your control panel and open the **Files** tab
2. Open `server.properties`
3. Add the download URL:

```properties
resource-pack=https://download.mc-packs.net/pack/your-pack-hash.zip
```

4. Add the SHA-1 hash (recommended):

```properties
resource-pack-sha1=ae1f474756c0011f0837188b6be478da5764d495
```

The SHA-1 hash prevents players from redownloading the pack unnecessarily.

## Step 4: Restart Your Server

Save the file and restart your server. Players will now be prompted to download the resource pack when joining.

## Optional Settings

### Require the Resource Pack

Force players to accept the pack or be disconnected:

```properties
require-resource-pack=true
```

### Custom Prompt Message

Explain why the resource pack is required:

```properties
resource-pack-prompt=This server uses a custom texture pack for the best experience.
```

## Velocity/Proxy Networks

For networks using Velocity, manage resource packs across multiple servers with the [VelocityResourcepacks](https://modrinth.com/plugin/velocityresourcepacks) plugin.

## Troubleshooting

### Players not receiving the pack

- Verify the URL is a direct download link (not a webpage)
- Check the URL is accessible (paste it in a browser)
- Ensure the SHA-1 hash is correct

### Pack downloads every time

- Add or verify the SHA-1 hash in `resource-pack-sha1`

### Pack not loading correctly

- The pack may be incompatible with the Minecraft version
- Check pack structure (must have `assets` folder at root of zip)

## See Also

- [Configuring server.properties](/game-servers/minecraft/server-properties)
- [Adding Datapacks](/game-servers/minecraft/datapacks)
