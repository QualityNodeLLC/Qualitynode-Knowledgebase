---
title: Configuring server.properties
description: Complete guide to customizing your Minecraft server through the server.properties configuration file.
order: 4
author: Brian Neumann-Fopiano
---

# Configuring server.properties

The `server.properties` file contains essential configuration settings for your Minecraft server. Access it through your server's **Files** tab.

> [!IMPORTANT]
> Restart your server after making changes. World generation modifications may require deleting existing world folders.

## World settings

### level-seed

```properties
level-seed=-1696067516
```

The seed determines world terrain generation. Find your singleplayer world's seed with `/seed` and paste it here for identical terrain.

### level-name

```properties
level-name=world
```

Specifies which world folder to load. Useful for switching between multiple saved worlds.

### level-type

```properties
level-type=minecraft:normal
```

Options:
- `minecraft:normal` - Standard generation
- `minecraft:flat` - Superflat world
- `minecraft:large_biomes` - Larger biome sizes
- `minecraft:amplified` - Extreme terrain heights

## Gameplay settings

### gamemode

```properties
gamemode=survival
```

Options: `survival`, `creative`, `adventure`, `spectator`

Use `force-gamemode=true` to override player-specific settings on join.

### difficulty

```properties
difficulty=normal
```

Options: `peaceful`, `easy`, `normal`, `hard`

### hardcore

```properties
hardcore=false
```

Locks difficulty to Hard. Deceased players enter Spectator Mode.

## Player and access settings

### max-players

```properties
max-players=20
```

Maximum concurrent players. Server optimization becomes critical above 100 players.

### online-mode

```properties
online-mode=true
```

> [!CAUTION]
> Keep this enabled to prevent unauthorized/cracked accounts and impersonation. Only disable when using a proxy with proper forwarding.

### white-list

```properties
white-list=true
```

Enabled by default. Prevents unwanted players from joining.

## Protection and building

### spawn-protection

```properties
spawn-protection=16
```

Radius in blocks around spawn protected from non-operator modifications. Set to `0` to disable.

## Performance settings

### view-distance

```properties
view-distance=10
```

Maximum render distance for all players. Lower values improve performance.

### simulation-distance

```properties
simulation-distance=6
```

Radius around players where entities are actively simulated. Lower values reduce entity lag but affect mob farms.

> [!TIP]
> For laggy servers, try `view-distance=8` and `simulation-distance=4` as a starting point.

## Server messaging

### motd

```properties
motd=Welcome to my server!
```

Message shown in the server list. Use `\n` for line breaks.

Tools like [mctools.org's MOTD Creator](https://mctools.org/motd-creator) help with formatting and colors.

## Resource packs

### resource-pack

```properties
resource-pack=https://download.mc-packs.net/pack/example.zip
```

URL to automatically download when players join. Use a URL that is directly
reachable by players and matches the resource-pack hash you configured.

### resource-pack-sha1

```properties
resource-pack-sha1=ae1f474756c0011f0837188b6be478da5764d495
```

Prevents clients from redownloading the pack unnecessarily.

### require-resource-pack

```properties
require-resource-pack=false
```

Set to `true` to require acceptance before joining.

## Security settings

### enforce-secure-profile

```properties
enforce-secure-profile=true
```

Enables chat signing (1.19.1+). Disable if causing mod compatibility issues.

### allow-flight

```properties
allow-flight=true
```

Enabled by default on QualityNode. Prevents false "flying" kicks when players use minecarts or boats.

## Settings moved to game rules

As of Minecraft 1.21.9, these settings are now controlled via `/gamerule`:

| Old Property | New Game Rule |
|--------------|---------------|
| `pvp` | `pvp` |
| `enable-command-block` | `commandBlocksEnabled` |
| `allow-nether` | `allowEnteringNetherUsingPortals` |

## Quick reference

| Setting | Recommended Value | Purpose |
|---------|------------------|---------|
| `online-mode` | `true` | Security |
| `white-list` | `true` | Privacy |
| `view-distance` | `8-10` | Performance |
| `simulation-distance` | `4-6` | Performance |
| `spawn-protection` | `0-16` | Build protection |
