---
title: Connect to Minehut
description: Allow Minehut players to join your QualityNode server.
order: 27
author: Brian Neumann-Fopiano
---

# Connect to Minehut

Enable players from the Minehut network to connect to your QualityNode Minecraft server.

## What is Minehut?

Minehut is a free Minecraft server platform with a large player community. By connecting your server, Minehut players can join using `/join <servername>` from the Minehut lobby.

## Prerequisites

- A QualityNode Minecraft server (Paper-based recommended)
- A Minehut External Server plan ($5/month from Minehut)

## Setup Steps

### Step 1: Get Your Server Details

1. Go to your QualityNode control panel
2. Select your server
3. Copy the IP address and port from the top-right of the console

### Step 2: Purchase Minehut External Server Plan

1. Visit the [Minehut control panel](https://minehut.com/)
2. Purchase an External Server plan (~$5/month)
3. Configure your external server settings

### Step 3: Configure Minehut

In Minehut's external server settings:
- Enter your QualityNode server IP and port
- Select server type: **Standalone/Paper** (or **Velocity** if using a proxy)

### Step 4: Enable Minehut Support on QualityNode

1. In your QualityNode control panel, go to the **Startup** tab
2. Enable the **"Enable Minehut Support"** option

### Step 5: Configure Server Files

#### Edit server.properties

```properties
enforce-secure-profile=false
```

#### Edit config/paper-global.yml

```yaml
proxies:
  proxy-protocol: true
```

### Step 6: Restart and Connect

1. Restart your server
2. Players can now join from Minehut using `/join <your-server-name>`

## Custom Domain (Optional)

Minehut supports custom domains that route through their network. See Minehut's documentation for setup instructions.

## Troubleshooting

### Players can't connect from Minehut

- Verify Minehut Support is enabled in Startup settings
- Check that `proxy-protocol: true` is set
- Confirm your server IP and port are correct in Minehut

### Connection times out

- Ensure `enforce-secure-profile` is set to `false`
- Verify your server is running and accessible

### "Unknown host" error

- Wait for Minehut's systems to update (can take a few minutes)
- Double-check the IP and port configuration

## See Also

- [Custom Domains](/game-servers/minecraft/custom-domain)
- [Getting Started](/game-servers/minecraft/getting-started)
