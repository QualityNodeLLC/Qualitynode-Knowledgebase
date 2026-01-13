---
title: Velocity Proxy Setup
description: Create a multi-server Minecraft network using Velocity proxy.
order: 25
author: Brian Neumann-Fopiano
---

# Velocity Proxy Setup

Velocity is a high-performance proxy that links multiple Minecraft servers under a single IP address, creating a seamless network experience.

## What is a Proxy?

A proxy server acts as a gateway that forwards player connections to backend servers. Players connect once and can switch between servers (lobby, survival, creative, etc.) without disconnecting.

## Prerequisites

- Two or more Paper-based Minecraft servers
- A Velocity proxy server (contact QualityNode support to provision one)

## Configuration Steps

### Step 1: Configure the Proxy

1. Access your proxy server in the control panel
2. Go to the **Files** tab
3. Open `velocity.toml`
4. Edit the `[servers]` section to add your backend servers:

```toml
[servers]
lobby = "172.18.0.1:25565"
survival = "172.18.0.2:25565"
creative = "172.18.0.3:25565"

try = ["lobby"]
```

Replace the addresses with your actual backend server internal IPs.

### Step 2: Get the Forwarding Secret

1. In your proxy's **Files** tab, open `forwarding.secret`
2. Copy the entire text content

This secret enables secure communication between the proxy and backend servers.

### Step 3: Restart the Proxy

Restart your proxy to apply the configuration changes.

### Step 4: Configure Backend Servers

For **each** backend server:

#### Edit server.properties

```properties
online-mode=false
network-compression-threshold=-1
```

> [!IMPORTANT]
> Setting `online-mode=false` on backend servers is safe because the proxy handles authentication. Never expose backend servers directly to the internet.

#### Edit config/paper-global.yml

```yaml
proxies:
  velocity:
    enabled: true
    online-mode: true
    secret: "paste-your-forwarding-secret-here"
```

### Step 5: For Fabric Servers

If any backend server runs Fabric, install [FabricProxy-Lite](https://modrinth.com/mod/fabricproxy-lite) and configure it with your forwarding secret.

### Step 6: For Geyser (Bedrock Support)

To allow Bedrock players on your network:

1. Remove Geyser from backend servers
2. Install [Geyser-Velocity](https://modrinth.com/plugin/geyser) on the proxy
3. Install [Floodgate-Velocity](https://modrinth.com/plugin/floodgate) on the proxy

### Step 7: Launch and Test

Start all servers and connect through the proxy. Use `/server <name>` to switch between servers.

## Useful Proxy Plugins

| Plugin | Purpose |
|--------|---------|
| [LuckPerms](https://luckperms.net/) | Cross-server permissions |
| [LimboQueue](https://modrinth.com/plugin/limboqueue) | Queue system for full servers |
| [VelocityResourcepacks](https://modrinth.com/plugin/velocityresourcepacks) | Server-specific resource packs |

## Architecture Example

```
Players
   |
   v
[Velocity Proxy] ----+---- [Lobby Server]
                     |
                     +---- [Survival Server]
                     |
                     +---- [Creative Server]
```

## Troubleshooting

### "If you see this error, a proxy is attempting to connect..."

- Verify the forwarding secret matches between proxy and backend
- Ensure `online-mode: true` is set in paper-global.yml velocity section
- Check that velocity is enabled in paper-global.yml

### Players can't switch servers

- Verify server names in velocity.toml match exactly
- Check backend servers are running and accessible
- Review proxy logs for connection errors

### High latency between servers

- Use internal IPs (172.x.x.x) for backend connections
- Ensure all servers are in the same datacenter

## See Also

- [Proxy Software Comparison](/game-servers/minecraft/proxy-comparison)
- [Bedrock Crossplay](/game-servers/minecraft/bedrock-crossplay)
- [MySQL Databases](/game-servers/minecraft/mysql-database)
