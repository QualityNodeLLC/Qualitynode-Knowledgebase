---
title: Pre-generate Your World with Chunky
description: Reduce lag by pre-generating world chunks before players explore them.
order: 13
author: Brian Neumann-Fopiano
---

# Pre-generate Your World with Chunky

Chunky pre-generates world chunks before players explore them, eliminating lag caused by real-time chunk generation.

## Pre-generation benefits

When players explore new areas, your server must generate terrain on the fly. This causes:
- TPS drops during exploration
- Rubber-banding for players
- Increased CPU usage

Pre-generation handles this work in advance, resulting in smooth gameplay.

## Installation

Download Chunky from [Modrinth](https://modrinth.com/plugin/chunky) and install it like any other mod or plugin.

Install Chunky using the plugin installation workflow currently shown by your
server panel.

## Basic usage

### Step 1: Select your world

Specify which dimension to generate:

**Paper servers:**
```
chunky world world
chunky world world_nether
chunky world world_the_end
```

**Fabric/Forge servers:**
```
chunky world overworld
chunky world the_nether
chunky world the_end
```

### Step 2: Set the radius

Define how many blocks to generate in each direction from spawn:

```
chunky radius 10000
```

### Storage requirements

| Radius | Approximate Size |
|--------|------------------|
| 5,000 blocks | ~5 GB |
| 10,000 blocks | ~17 GB |
| 15,000 blocks | ~38 GB |
| 20,000 blocks | ~68 GB |

> [!WARNING]
> Large pre-generation tasks require significant storage. Check your available disk space before starting.

### Step 3: Start generation

```
chunky start
```

Generation can take many hours for large radii. The server remains playable during this process, though with slightly reduced performance.

### Reduce console spam

```
chunky silent
```

## Control commands

| Command | Description |
|---------|-------------|
| `chunky pause` | Temporarily stop generation |
| `chunky continue` | Resume generation |
| `chunky cancel` | Abandon generation entirely |
| `chunky progress` | Check current progress |

## Important notes

### Generated vs loaded chunks

Pre-generated chunks are **not** loaded. They're saved to disk but require a player nearby to become active.

This means:
- Mob farms still need player presence
- Automated systems don't run in unloaded chunks
- Generation only eliminates the *creation* lag, not loading lag

### Always-loaded chunks

For chunks that need to stay active:
- Spawn chunks (small area around world spawn)
- Use `/forceload` to permanently load specific chunks

## Alternative: World border

Set a world border before pre-generating to limit exploration:

```
worldborder center 0 0
worldborder set 20000
```

Then pre-generate only within that border.

## See also

- [Diagnosing Server Lag](/game-servers/minecraft/diagnosing-lag)
- [Reset Your World](/game-servers/minecraft/reset-world)
