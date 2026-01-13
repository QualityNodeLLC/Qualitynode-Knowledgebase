---
title: Adding Datapacks
description: How to install datapacks for vanilla-compatible modifications to your Minecraft server.
order: 9
author: Brian Neumann-Fopiano
---

# Adding Datapacks

Datapacks are vanilla-compatible packs that modify server behavior without requiring mods. They can add biomes, adjust game mechanics, create custom recipes, and more.

## What Are Datapacks?

Datapacks work with any Minecraft server software (including vanilla) and don't require clients to install anything. They're perfect for:

- Adding custom biomes and structures
- Tweaking game mechanics
- Custom crafting recipes
- Loot table modifications
- Custom advancements

## Installation Steps

### Step 1: Download a Datapack

Recommended sources:
- [Modrinth Datapacks](https://modrinth.com/datapacks)
- [Planet Minecraft](https://planetminecraft.com/data-packs)
- [Vanilla Tweaks](https://vanillatweaks.net/picker/datapacks)

### Step 2: Access the Datapack Folder

1. Go to your control panel and select your server
2. Click **Files** in the sidebar
3. Navigate to your world folder (usually named `world`)
4. Open the `datapacks` folder

### Step 3: Upload Your Datapack

Drag and drop the `.zip` file into the browser window.

> [!NOTE]
> For Vanilla Tweaks, you may need to extract the downloaded file first, then upload the individual datapack zip files.

### Step 4: Activate and Verify

Restart your server, then verify the datapack loaded:

```
datapack list
```

This shows all enabled and available datapacks.

## Managing Datapacks

### Enable a Datapack

```
datapack enable "file/<datapack_name>"
```

### Disable a Datapack

```
datapack disable "file/<datapack_name>"
```

## Performance Considerations

> [!WARNING]
> Heavy datapacks can impact server performance. Lightweight packs like Vanilla Tweaks typically cause no issues, but complex terrain generation or entity modifications may increase lag.

If you experience performance issues:
1. Disable datapacks one by one to identify the culprit
2. Use fewer or simpler datapacks
3. Consider using mods instead for complex modifications

## Multi-World Servers

Datapacks uploaded to your main world's datapack folder apply globally across all dimensions (Overworld, Nether, End).

## Troubleshooting

### Datapack not appearing in list

- Ensure the file is a valid `.zip` archive
- Check it's in the correct `datapacks` folder
- Verify the datapack is compatible with your Minecraft version

### Datapack not working

- Check server logs for errors
- The datapack may require a world reset to take effect (for world generation changes)
- Some datapacks conflict with each other

## See Also

- [Reset Your World](/game-servers/minecraft/reset-world)
- [Adding Resource Packs](/game-servers/minecraft/resource-packs)
