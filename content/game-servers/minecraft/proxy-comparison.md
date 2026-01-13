---
title: Proxy Software Comparison
description: Compare Velocity, BungeeCord, and Waterfall to choose the right proxy for your network.
order: 26
author: Brian Neumann-Fopiano
---

# Proxy Software Comparison

Proxy servers enable linking multiple Minecraft servers under a single IP address. This guide compares available options.

## Quick Recommendation

> **Use Velocity.** It's the only proxy software recommended for new networks in 2025.

## Velocity (Recommended)

Velocity is a modern, high-performance proxy designed for reliability and speed.

### Advantages

- **Excellent performance:** Handles 1,000+ concurrent players with minimal overhead
- **Modern security:** Secure player data forwarding by default
- **Active development:** Regular updates and improvements
- **Wide compatibility:** Supports Paper servers, modded servers (with mods), and Minecraft 1.7+
- **Geyser support:** Built-in Bedrock Edition crossplay capability
- **Easy configuration:** Straightforward setup process

### Plugin Availability

Find Velocity plugins on:
- [Modrinth](https://modrinth.com/plugins?g=categories:velocity)
- [Hangar](https://hangar.papermc.io/?platform=VELOCITY)

Most popular proxy plugins support Velocity.

## BungeeCord / Waterfall (Not Recommended)

BungeeCord was the original Minecraft proxy. Waterfall was its maintained fork.

### Why Avoid Them

- **No longer actively developed:** Waterfall has reached end-of-life
- **Security concerns:** Uses insecure player data transmission by default
- **Inferior performance:** Cannot match Velocity's efficiency
- **Outdated architecture:** Designed for an older era of Minecraft networking

### Legacy Use Cases

If you absolutely must use legacy proxy software for compatibility:
- Waterfall is more stable than original BungeeCord
- Consider migrating to Velocity instead

## Large Network Example

Major networks like Hypixel demonstrate enterprise-scale proxy deployment:

- Multiple load-balanced Velocity proxies
- DDoS protection via Cloudflare
- Thousands of individual game mode servers
- Separate lobbies for different games

While most servers won't need this scale, Velocity can grow with your network.

## Migration from BungeeCord

If you're currently using BungeeCord or Waterfall:

1. Install Velocity on a new proxy server
2. Update velocity.toml with your server configuration
3. Configure backend servers for Velocity forwarding
4. Update plugins to Velocity-compatible versions
5. Switch DNS/connection to the new proxy

Most plugins have Velocity versions or alternatives available.

## See Also

- [Velocity Proxy Setup](/game-servers/minecraft/velocity-proxy)
- [Bedrock Crossplay](/game-servers/minecraft/bedrock-crossplay)
