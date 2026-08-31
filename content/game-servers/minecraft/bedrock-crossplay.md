---
title: Bedrock Crossplay
description: Allow Minecraft Bedrock Edition players to join your Java Edition server.
order: 19
author: Brian Neumann-Fopiano
draft: true
---

# Bedrock Crossplay

Allow players using Minecraft Bedrock Edition (mobile, console, Windows 10/11) to join your Java Edition server.

## Requirements

- **Paper-based server software** (Paper, Purpur, or similar)
- **Latest Minecraft version** for best compatibility

> [!WARNING]
> Modded servers (Fabric, Forge) do not currently support Bedrock crossplay.

## Setup Steps

### Step 1: Access Your Control Panel

Go to your control panel and select your server.

### Step 2: Install Paper Software

If not already using Paper:

1. Click **Software** in the sidebar
2. Select **Paper** as your server software
3. Choose the latest available Minecraft version

> [!TIP]
> If Paper isn't available for the newest Minecraft version yet, install the latest option available and add the [ViaVersion](https://modrinth.com/plugin/viaversion) plugin to allow newer clients to connect.

### Step 3: Enable Bedrock Crossplay

During software installation, select the **"Enable Bedrock crossplay?"** option.

This automatically installs and configures [Geyser](https://geysermc.org/) and [Floodgate](https://github.com/GeyserMC/Floodgate) for you.

<!-- TODO: Add screenshot of the crossplay option -->

### Step 4: Start Your Server

Launch your server. Bedrock players can now connect using the same IP and port as Java players.

## How Players Connect

### Java Edition

Connect normally using your server IP and port.

### Bedrock Edition

1. Add a new server in Minecraft
2. Enter your server's IP address
3. Enter the port number

> [!NOTE]
> Unlike Java Edition, Bedrock players must enter the port separately. Custom domains with SRV records won't work without specifying the port.

## Custom Bedrock Port

By default, Bedrock players use the same port as Java players. If you need the standard Bedrock port (19132), contact QualityNode support.

## Player Name Prefixes

Bedrock players appear with a `.` prefix before their username (e.g., `.BedrockPlayer`). This distinguishes them from Java players and prevents name conflicts.

## Limitations

- Some Java features may not work identically for Bedrock players
- Custom resource packs require Bedrock-compatible versions
- Certain plugins may have compatibility issues
- Performance overhead from translation

## Troubleshooting

### Bedrock players can't connect

- Verify the server is running Paper (not Fabric/Forge)
- Check that Geyser plugin loaded (use `plugins` command)
- Ensure players are entering the correct port

### Connection times out

- Try the standard Bedrock port if available
- Check for firewall issues
- Verify the server IP is correct

### Visual glitches or missing features

- This is normal - Geyser translates between different game versions
- Some Java-specific features may appear differently

## See Also

- [Choosing Server Software](/game-servers/minecraft/server-software)
- [Custom Domains](/game-servers/minecraft/custom-domain)
