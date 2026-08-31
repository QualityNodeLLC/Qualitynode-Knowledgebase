---
title: Minecraft Server Commands Reference
description: Essential commands for managing your Minecraft server, from player management to world configuration.
order: 5
author: Brian Neumann-Fopiano
---

# Minecraft Server Commands Reference

Use these commands to manage players, world settings, saves, and server state.

## Command syntax

- Arguments in `<brackets>` are **required**
- Arguments in `[brackets]` are **optional**
- Remove the brackets when running commands
- Console commands don't need a `/` prefix; in-game commands do

To see all available commands, use `/help` in-game.

## Player management

### Operator permissions

```
op <player>
```

Grants operator (admin) permissions. Only op trusted players, as they can execute any command.

```
deop <player>
```

Removes operator permissions.

### Whitelist

```
whitelist <on|off>
```

Enables or disables the whitelist.

```
whitelist add <player>
whitelist remove <player>
whitelist list
```

Manage which players can join your server.

### Banning

```
ban <player> [reason]
ban-ip <ip> [reason]
pardon <player>
pardon-ip <ip>
```

Block players or IP addresses from joining.

### Current players

```
list
```

Shows all currently connected players.

## Gameplay commands

### Game mode

```
gamemode <survival|creative|adventure|spectator> [player]
```

Changes a player's game mode.

### Teleportation

```
tp <player> <x> <y> <z>
tp <player> <target>
```

Teleports players to coordinates or other players.

### Items

```
give <player> <item> [amount]
clear <player> [item] [count]
```

Give or remove items from player inventories.

### Kill

```
kill <target>
```

Eliminates entities (players, mobs, etc.).

## World settings

### Spawn point

```
setworldspawn <x> <y> <z>
```

Sets the world's default spawn location.

### Time

```
time set <day|night|noon|midnight>
time set <ticks>
time add <amount>
```

Controls the time of day.

### Weather

```
weather <clear|rain|thunder> [duration]
```

Sets weather conditions.

### Difficulty

```
difficulty <peaceful|easy|normal|hard>
```

Changes the server difficulty.

### Seed

```
seed
```

Displays the world seed.

## Game rules

Game rules adjust server mechanics. View all with `/gamerule` and set with:

```
gamerule <rule> <value>
```

### Useful game rules

| Rule | Default | Description |
|------|---------|-------------|
| `doDaylightCycle` | true | Time progresses naturally |
| `doMobSpawning` | true | Mobs spawn naturally |
| `doFireTick` | true | Fire spreads |
| `mobGriefing` | true | Mobs can modify blocks |
| `keepInventory` | false | Players keep items on death |
| `pvp` | true | Players can damage each other |
| `doInsomnia` | true | Phantoms spawn |
| `playersSleepingPercentage` | 100 | Percentage needed to skip night |

**Example:** Disable phantoms:
```
gamerule doInsomnia false
```

**Example:** Allow one player to skip night:
```
gamerule playersSleepingPercentage 1
```

> [!NOTE]
> As of Minecraft 1.21.9, some settings previously in `server.properties` (like `pvp`, `enable-command-block`, and `allow-nether`) have been moved to game rules.

## Save commands

```
save-all
save-on
save-off
```

Force save, or enable/disable automatic saving.

## Server control

```
stop
```

Safely shuts down the server.

> [!WARNING]
> Always use `stop` rather than force-killing the server to prevent world corruption.
