---
title: Adding Datapacks
description: How to install datapacks for vanilla-compatible modifications to your Minecraft server.
order: 9
author: Brian Neumann-Fopiano
---

# Adding Datapacks

Datapacks modify server behavior without requiring mods. They can add biomes, adjust game mechanics, and define custom recipes.

## Datapacks

Datapacks work with vanilla-compatible server software and don't require a client install. Common uses include:

- Adding custom biomes and structures
- Tweaking game mechanics
- Custom crafting recipes
- Loot table modifications
- Custom advancements

## Installation steps

### Step 1: Download a datapack

Recommended sources:
- [Modrinth Datapacks](https://modrinth.com/datapacks)
- [Planet Minecraft](https://planetminecraft.com/data-packs)
- [Vanilla Tweaks](https://vanillatweaks.net/picker/datapacks)

### Step 2: Open the datapack folder

1. Go to your control panel and select your server
2. Click **Files** in the sidebar
3. Navigate to your world folder (usually named `world`)
4. Open the `datapacks` folder

### Step 3: Upload your datapack

Drag and drop the `.zip` file into the browser window.

> [!NOTE]
> For Vanilla Tweaks, you may need to extract the downloaded file first, then upload the individual datapack zip files.

### Step 4: Activate and verify

Restart your server, then verify the datapack loaded:

```
datapack list
```

The command lists enabled and available datapacks.

## Managing datapacks

### Enable a datapack

```
datapack enable "file/<datapack_name>"
```

### Disable a datapack

```
datapack disable "file/<datapack_name>"
```

## Performance considerations

> [!WARNING]
> Heavy datapacks can impact server performance. Lightweight packs like Vanilla Tweaks typically cause no issues, but complex terrain generation or entity modifications may increase lag.

If you experience performance issues:
1. Disable datapacks one by one to identify the culprit
2. Use fewer or simpler datapacks
3. Consider using mods instead for complex modifications

## Multi-world servers

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

## See also

- [Reset Your World](/game-servers/minecraft/reset-world)
