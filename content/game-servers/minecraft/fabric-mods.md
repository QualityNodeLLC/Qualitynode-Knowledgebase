---
title: Pre-installed Fabric Mods
description: Overview of the optimization mods automatically installed on QualityNode Fabric servers.
order: 8
author: Brian Neumann-Fopiano
---

# Pre-installed Fabric Mods

QualityNode automatically installs five optimization mods on new Fabric servers. These are server-side only and require no client installation from players.

## Included Mods

### Fabric API

**Purpose:** Essential hooks for modding with Fabric.

Nearly mandatory for running additional mods. Pre-installed to save you the setup step.

### Lithium

**Purpose:** Optimizes game logic and server performance.

Lithium improves server tick times without altering vanilla mechanics. We recommend keeping this installed for the best player experience.

### Krypton

**Purpose:** Network stack optimization.

Uses technology from the Velocity proxy to improve server connectivity and reduce bandwidth usage.

### Alternate Current

**Purpose:** Redstone system optimization.

Significantly improves performance with large redstone contraptions and farms.

> [!NOTE]
> In rare cases, Alternate Current may cause redstone behavior to differ slightly from vanilla. Monitor your redstone builds after installation.

### spark

**Purpose:** Performance profiling and diagnostics.

A passive diagnostic tool for monitoring server health. Useful commands:

```
spark health
```
Shows current TPS and memory usage.

```
spark profiler open
```
Generates a detailed performance report for troubleshooting lag.

See [Diagnosing Server Lag](/game-servers/minecraft/diagnosing-lag) for more on using spark.

## Managing Pre-installed Mods

You have full control over these mods:

- **To remove:** Delete the mod file from the `/mods` folder
- **To update:** Replace with a newer version from Modrinth
- **To keep:** No action needed

> [!TIP]
> We recommend keeping all pre-installed mods active. They're carefully selected to maximize server stability and performance without affecting gameplay.

## Adding More Mods

Looking to add additional mods? See:
- [Uploading Mods and Plugins](/game-servers/minecraft/mods-plugins)
- [Installing Modpacks](/game-servers/minecraft/modpacks)
