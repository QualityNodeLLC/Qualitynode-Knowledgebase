---
title: Diagnosing Server Lag
description: How to identify and fix performance issues on your Minecraft server.
order: 14
author: Brian Neumann-Fopiano
---

# Diagnosing Server Lag

Start by separating server lag from client FPS or connection problems.

## Types of lag

Before troubleshooting, identify which type of lag you're experiencing:

| Type | Symptoms | Affects |
|------|----------|---------|
| **Server lag** | Delayed block breaking, mob AI issues, rubber-banding | All players |
| **Client FPS drops** | Choppy visuals, low framerate | Individual player |
| **Connection lag** | High ping, delayed actions | Individual player |

### Connection issues (one player)

If only one player experiences lag:
- Check their internet connection
- Try using [Cloudflare 1.1.1.1](https://1.1.1.1/) for improved DNS
- Verify they're connecting to the nearest server region

### Client FPS issues

If a player has low FPS:
- Increase allocated RAM in their launcher
- Install client-side optimization mods:
  - [Sodium](https://modrinth.com/mod/sodium) (Fabric)
  - [Entity Culling](https://modrinth.com/mod/entityculling)
  - [Starlight](https://modrinth.com/mod/starlight)

## Diagnosing server lag

### Step 1: Install spark

[Spark](https://modrinth.com/plugin/spark) is a performance profiling tool. It comes pre-installed on:
- QualityNode Fabric/Forge modded servers
- Paper-based plugin servers

If not installed, add it from Modrinth.

### Step 2: Check TPS

Run this command in your console:

```
spark tps
```

**Interpreting results:**

| TPS | Status |
|-----|--------|
| 20.0 | Perfect |
| 18-19 | Minor issues |
| 15-17 | Noticeable lag |
| Below 15 | Significant problems |

A consistent 20.0 TPS means the server isn't overloaded. Look for connection or client issues instead.

### Step 3: Generate a profile

If TPS drops below 20, create a performance report:

```
spark profiler start
```

Wait 1-2 minutes while the server is lagging, then:

```
spark profiler stop
```

Spark returns a shareable profile link.

### Step 4: Analyze the profile

The profiler shows what's consuming server resources. Click through the tree to identify:

- Which mods/plugins use the most tick time
- Entity processing overhead
- World generation costs

## Common causes and solutions

### Too many entities

**Symptoms:** Lag in specific areas with many mobs/items

**Solutions:**
- Kill excess entities: `/kill @e[type=item]`
- Reduce `simulation-distance` in server.properties
- Add mob stacking plugins (Paper servers)
- Clear item entities regularly

### Chunk generation lag

**Symptoms:** Lag when players explore new areas

**Solutions:**
- [Pre-generate your world with Chunky](/game-servers/minecraft/chunky)
- Set a world border to limit exploration
- Reduce `view-distance`

### Heavy datapacks

**Symptoms:** Constant low TPS, visible in spark profile

**Solutions:**
- Remove or disable resource-intensive datapacks
- Use mods instead for complex modifications

### Problematic mods/plugins

**Symptoms:** Specific mod/plugin appears high in spark profile

**Solutions:**
- Check mod documentation for known issues
- Update to the latest version
- Remove or replace the problematic mod
- Contact the modpack maintainers for pre-made packs

### Redstone machines

**Symptoms:** Lag when near large redstone contraptions

**Solutions:**
- Use [Alternate Current](https://modrinth.com/mod/alternate-current) (Fabric)
- Optimize or reduce redstone complexity
- Disable redstone when not in use

## Server settings to adjust

In `server.properties`:

```properties
view-distance=8
simulation-distance=4
```

For Paper servers, also check `config/paper-world-defaults.yml` for additional optimization options.

## Getting help

If you can't resolve the issue:

1. Generate a spark profile
2. Note your server software and version
3. List installed mods/plugins
4. Contact QualityNode support with this information

## See also

- [Pre-generate with Chunky](/game-servers/minecraft/chunky)
