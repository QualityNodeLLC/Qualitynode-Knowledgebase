---
title: Rust Server Setup
description: Guide to setting up and configuring your Rust dedicated server.
icon: shield
order: 3
tags: [rust, survival, popular]
author: Brian Neumann-Fopiano
---

# Rust Server Setup

Run your own Rust server with full control over settings, plugins, and gameplay.

## Quick Setup

1. Create a new server and select **Rust**
2. Configure your server name and description
3. Set your map size and seed
4. Choose whether to enable EasyAntiCheat

## Server Configuration

Customize your server via startup parameters or the `server.cfg` file:

```
server.hostname "My QualityNode Rust Server"
server.description "Welcome! PvP enabled, active admins."
server.maxplayers 100
server.worldsize 3500
server.seed 12345
```

## Map Options

| Map Size | Players | Performance |
|----------|---------|-------------|
| 2000 | 50 | Excellent |
| 3000 | 100 | Good |
| 4000 | 150+ | Moderate |
| 4500 | 200+ | Intensive |

## Installing Oxide/uMod

Oxide adds plugin support to your Rust server:

1. Go to your control panel
2. Click **Mods** or **Mod Manager**
3. Install **Oxide/uMod**
4. Restart your server

### Popular Plugins

- **Gather Manager** - Adjust resource gathering rates
- **Stack Size Controller** - Modify stack sizes
- **Quick Smelt** - Faster smelting
- **Kits** - Give players starter kits

## RCON Access

Connect remotely using RCON:

```
rcon.password "your_password"
rcon.port 28016
rcon.ip 0.0.0.0
```

> [!CAUTION]
> Always use a strong RCON password and keep it private.

## Recommended Plans

| Server Size | Recommended Plan |
|-------------|-----------------|
| Small (50 players) | Agent |
| Medium (100 players) | Director |
| Large (150+ players) | Astral |
