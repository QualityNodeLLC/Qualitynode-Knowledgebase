---
title: Diagnosing Server Lag
description: How to identify and fix performance issues on your Minecraft server.
order: 14
author: Brian Neumann-Fopiano
---

# Diagnosing Server Lag

This guide provides a systematic approach to identifying and resolving server lag issues.

## Types of Lag

Before troubleshooting, identify which type of lag you're experiencing:

| Type | Symptoms | Affects |
|------|----------|---------|
| **Server lag** | Delayed block breaking, mob AI issues, rubber-banding | All players |
| **Client FPS drops** | Choppy visuals, low framerate | Individual player |
| **Connection lag** | High ping, delayed actions | Individual player |

### Connection Issues (One Player)

If only one player experiences lag:
- Check their internet connection
- Try using [Cloudflare 1.1.1.1](https://1.1.1.1/) for improved DNS
- Verify they're connecting to the nearest server region

### Client FPS Issues

If a player has low FPS:
- Increase allocated RAM in their launcher
- Install client-side optimization mods:
  - [Sodium](https://modrinth.com/mod/sodium) (Fabric)
  - [Entity Culling](https://modrinth.com/mod/entityculling)
  - [Starlight](https://modrinth.com/mod/starlight)

## Diagnosing Server Lag

### Step 1: Install Spark

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

### Step 3: Generate a Profile

If TPS drops below 20, create a performance report:

```
spark profiler start
```

Wait 1-2 minutes while the server is lagging, then:

```
spark profiler stop
```

This generates a shareable link to analyze.

### Step 4: Analyze the Profile

The profiler shows what's consuming server resources. Click through the tree to identify:

- Which mods/plugins use the most tick time
- Entity processing overhead
- World generation costs

## Common Causes and Solutions

### Too Many Entities

**Symptoms:** Lag in specific areas with many mobs/items

**Solutions:**
- Kill excess entities: `/kill @e[type=item]`
- Reduce `simulation-distance` in server.properties
- Add mob stacking plugins (Paper servers)
- Clear item entities regularly

### Chunk Generation Lag

**Symptoms:** Lag when players explore new areas

**Solutions:**
- [Pre-generate your world with Chunky](/game-servers/minecraft/chunky)
- Set a world border to limit exploration
- Reduce `view-distance`

### Heavy Datapacks

**Symptoms:** Constant low TPS, visible in spark profile

**Solutions:**
- Remove or disable resource-intensive datapacks
- Use mods instead for complex modifications

### Problematic Mods/Plugins

**Symptoms:** Specific mod/plugin appears high in spark profile

**Solutions:**
- Check mod documentation for known issues
- Update to the latest version
- Remove or replace the problematic mod
- Contact the modpack maintainers for pre-made packs

### Redstone Machines

**Symptoms:** Lag when near large redstone contraptions

**Solutions:**
- Use [Alternate Current](https://modrinth.com/mod/alternate-current) (Fabric)
- Optimize or reduce redstone complexity
- Disable redstone when not in use

## Server Settings to Adjust

In `server.properties`:

```properties
view-distance=8
simulation-distance=4
```

For Paper servers, also check `config/paper-world-defaults.yml` for additional optimization options.

## Getting Help

If you can't resolve the issue:

1. Generate a spark profile
2. Note your server software and version
3. List installed mods/plugins
4. Contact QualityNode support with this information

## See Also

- [Pre-generate with Chunky](/game-servers/minecraft/chunky)
- [Pre-installed Fabric Mods](/game-servers/minecraft/fabric-mods)
- [Automatic Restarts](/game-servers/minecraft/automatic-restarts)
