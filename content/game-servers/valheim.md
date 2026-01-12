---
title: Valheim Server Setup
description: Set up your own Valheim dedicated server for Viking adventures.
icon: axe
order: 5
tags: [valheim, survival, viking]
---

# Valheim Server Setup

Host your own Valheim server for you and your Viking companions.

## Quick Setup

1. Create a new server and select **Valheim**
2. Set your server name and password
3. Choose your world name (or use existing save)
4. Start your server

## Server Configuration

Configure via startup parameters:

```
-name "My Viking Server"
-port 2456
-world "MyWorld"
-password "secretpassword"
-public 1
```

## World Management

### Creating a New World
Your server automatically creates a new world on first start.

### Using an Existing World
1. Navigate to **Files** in your control panel
2. Upload your world files to the `worlds` folder:
   - `WorldName.db`
   - `WorldName.fwl`
3. Set the world name in server settings

## Crossplay Support

Valheim supports crossplay between Steam and Xbox:

1. Enable crossplay in server settings
2. Players can join regardless of platform
3. Use the join code displayed in your control panel

## Performance Tips

- **Player Count**: Valheim performs best with 2-10 players
- **Base Building**: Large bases can impact performance
- **Portals**: Limit portal networks in high-traffic areas

> [!TIP]
> For the smoothest experience, keep your player count under 10 and avoid building mega-bases in one location.

## Mods (Valheim Plus)

Install Valheim Plus for enhanced features:

1. Go to **Mods** in your control panel
2. Install **Valheim Plus**
3. Configure via `valheim_plus.cfg`
4. All players need the same mods installed

## Recommended Plans

| Server Size | Recommended Plan |
|-------------|-----------------|
| Small group (2-5) | Threshold |
| Friends (5-10) | Agent |
| Community (10+) | Director |
