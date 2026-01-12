---
title: Console Commands
description: Use the server console to manage your game server in real-time.
icon: terminal
order: 6
tags: [console, commands, admin]
---

# Console Commands

The server console lets you execute commands and view server output in real-time.

## Accessing the Console

1. Select your server from the dashboard
2. Click **Console** in the sidebar
3. View live server output
4. Enter commands in the input field

## Sending Commands

Type your command and press `Enter` or click **Send**.

```
> your command here
```

> [!NOTE]
> Most game commands do not require a prefix. If a command doesn't work, try without the `/`.

## Common Commands by Game

### Minecraft

```
# Player management
list                    # Show online players
kick <player>           # Kick a player
ban <player>            # Ban a player
whitelist add <player>  # Add to whitelist

# Server control
stop                    # Stop the server
save-all                # Save world data
say <message>           # Broadcast message

# Game settings
difficulty <level>      # Set difficulty
gamemode <mode> <player> # Change gamemode
time set day            # Set time
```

### Rust

```
# Player management
status                  # List players
kick <steamid>          # Kick player
ban <steamid> <reason>  # Ban player

# Server control
server.save             # Save server
server.writecfg         # Save config
quit                    # Stop server

# Admin
moderatorid <steamid>   # Add moderator
ownerid <steamid>       # Add owner
```

### ARK

```
# Player management
ListPlayers             # Show online players
KickPlayer <steamid>    # Kick player
BanPlayer <steamid>     # Ban player

# Server control
SaveWorld               # Force save
DoExit                  # Stop server

# Admin
MakeTribeAdmin          # Make yourself admin
GiveItemNum <id> <qty>  # Give items
```

## Console Tips

- Use **Up Arrow** to recall previous commands
- Console output is color-coded by severity
- Errors appear in red, warnings in yellow
- Watch for startup errors when troubleshooting
