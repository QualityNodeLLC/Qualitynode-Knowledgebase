---
title: Simple Voice Chat
description: Add proximity-based voice communication to your Minecraft server.
order: 22
author: Brian Neumann-Fopiano
draft: true
---

# Simple Voice Chat

Simple Voice Chat enables proximity-based voice communication in Minecraft. Players can talk to nearby players, with volume based on distance.

## Overview

- Proximity-based audio (closer = louder)
- Works on both modded and plugin servers
- Requires client-side installation for players
- Supports groups and direct messaging

## Installation

### Step 1: Download the Mod/Plugin

Visit [Simple Voice Chat on Modrinth](https://modrinth.com/plugin/simple-voice-chat) and download the appropriate version:

- **Bukkit** version for Paper/Purpur servers
- **Fabric** version for Fabric servers
- **Forge** version for Forge servers

### Step 2: Upload to Your Server

1. Go to your control panel and select your server
2. Click **Files** in the sidebar
3. Navigate to the appropriate folder:
   - Paper/Purpur: `/plugins`
   - Fabric/Forge: `/mods`
4. Drag and drop the downloaded file

### Step 3: Restart Your Server

Restart to load the new mod/plugin.

### Step 4: Create a Dedicated Port

Voice chat requires its own UDP port:

1. In your control panel sidebar, click **Network**
2. Click **Create Port**
3. Copy the 5-digit port number provided

<!-- TODO: Add screenshot of port creation -->

### Step 5: Configure the Port

1. Navigate to **Files** in the sidebar
2. Open the configuration folder:
   - Mods: `config/voicechat/`
   - Plugins: `plugins/voicechat/`
3. Open `voicechat-server.properties`
4. Replace the port value with your new port:

```properties
port=12345
```

5. Save the file

### Step 6: Final Restart

Restart your server to apply the port configuration.

## Client Requirements

Players must install the matching mod on their client:

1. Download from [Modrinth](https://modrinth.com/mod/simple-voice-chat)
2. Install for their mod loader (Fabric or Forge)
3. Launch the game and join your server

> [!NOTE]
> The mod is client-side required. Players without the mod can still play but won't hear or use voice chat.

## In-Game Usage

Default keybinds:
- **V** - Push to talk (can be changed to toggle)
- **G** - Open voice chat menu

## Configuration Options

Common settings in `voicechat-server.properties`:

| Setting | Description |
|---------|-------------|
| `max_voice_distance` | Maximum hearing range (default: 48 blocks) |
| `crouch_distance_multiplier` | Range multiplier when crouching |
| `whisper_distance_multiplier` | Range for whisper mode |

## Troubleshooting

### Voice chat not connecting

- Verify the port is created and configured correctly
- Check that the port number matches in the config file
- Ensure players have the client mod installed

### Can't hear other players

- Both players need the mod installed
- Check in-game volume settings (press G)
- Verify you're within hearing range

### High latency or quality issues

- The voice chat port may have network issues
- Try creating a different port

## See Also

- [Uploading Mods and Plugins](/game-servers/minecraft/mods-plugins)
- [Getting Started](/game-servers/minecraft/getting-started)
