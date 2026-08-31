---
title: Reset Your World
description: How to delete and regenerate your Minecraft world with optional custom settings.
order: 12
author: Brian Neumann-Fopiano
---

# Reset Your World

Follow these steps to delete the current world and configure an optional seed or world type.

## Step 1: Stop your server

1. Go to your control panel and select your server
2. Click the **Stop** button

> [!WARNING]
> This process permanently deletes your world. Create a backup first if you want to keep it.

## Step 2: Delete world folders

1. Click the **Files** tab in the sidebar
2. Delete the `world` folder

**For Paper-based servers:** Also delete:
- `world_nether`
- `world_the_end`

**For non-Paper servers (Fabric/Forge):** Enter the `world` folder and delete:
- `DIM-1` (Nether only)
- `DIM1` (End only)

## Step 3: Set a custom seed (optional)

To use a specific world seed:

1. Open `server.properties` in the Files tab
2. Find the `level-seed=` line
3. Enter your desired seed value
4. Save the file

```properties
level-seed=12345678
```

Leave empty for a random seed.

## Step 4: Configure the world type (optional)

Modify the `level-type=` setting in server.properties:

| Value | Description |
|-------|-------------|
| `minecraft:normal` | Standard world generation |
| `minecraft:flat` | Superflat world |
| `minecraft:large_biomes` | Larger biome sizes |
| `minecraft:amplified` | Extreme terrain heights |

```properties
level-type=minecraft:amplified
```

## Step 5: Start your server

Click **Start** to boot your server. The new world generates automatically, typically within 10 seconds to 2 minutes depending on your settings.

## Resetting specific dimensions

### Reset only the Nether

**Paper servers:** Delete only `world_nether`

**Other servers:** Delete only `DIM-1` inside the `world` folder

### Reset only the End

**Paper servers:** Delete only `world_the_end`

**Other servers:** Delete only `DIM1` inside the `world` folder

## Keeping player data

If you want to reset the world but keep player inventories and progress:

1. Before deleting, copy the `playerdata` folder from inside `world`
2. Delete the world folders
3. Start the server to generate a new world
4. Stop the server
5. Paste the `playerdata` folder back into the new `world` folder
6. Start the server again

> [!NOTE]
> This preserves inventories but not player positions. Players spawn at the new world's spawn point.

## See also

- [Pre-generate with Chunky](/game-servers/minecraft/chunky)
