---
title: Custom Domains
description: Point your own domain name to your Minecraft server for a professional address.
order: 18
author: Brian Neumann-Fopiano
---

# Custom Domains

A custom domain provides a professional, memorable address for your server instead of a raw IP like `66.118.235.132:25565`.

## Domain Options

### Free Subdomain

QualityNode offers free subdomains through the **Network** tab in your control panel. Choose from options like:
- `yourserver.minecraft.horse`
- Other available domain endings

### Custom Domain

Purchase a domain from registrars like:
- [Porkbun](https://porkbun.com) (often cheapest)
- [Cloudflare](https://cloudflare.com/products/registrar)
- [Namecheap](https://namecheap.com)

Most domains cost $1-10 per year.

## Setup Instructions

### Step 1: Access DNS Management

Log into your domain registrar's control panel and find the DNS records section (sometimes labeled "Custom DNS" or "DNS Settings").

### Step 2: Create an A Record

Add a new DNS record with these settings:

| Field | Value |
|-------|-------|
| Type | A |
| Name | `play` (or `@` for root domain) |
| Address | Your server IP (without port) |
| TTL | Auto or 3600 |

**Example:** For `play.yourdomain.com` pointing to `66.118.235.132`

<!-- TODO: Add screenshot of DNS record configuration -->

> [!NOTE]
> **Cloudflare users:** Set the proxy status to "DNS only" (grey cloud). The orange cloud proxy breaks Minecraft connections.

### Step 3: Create an SRV Record (If Needed)

Only required if your server uses a non-standard port (not 25565):

| Field | Value |
|-------|-------|
| Type | SRV |
| Name | `_minecraft._tcp.play` |
| Priority | 0 |
| Weight | 0 |
| Port | Your server's port |
| Target | `play.yourdomain.com` |

Adjust the name to match your subdomain (e.g., `_minecraft._tcp` for root domain).

## DNS Propagation

DNS changes can take up to 24 hours to propagate globally, though most updates complete within a few hours.

You can check propagation status at [dnschecker.org](https://dnschecker.org/).

## Bedrock Edition Note

> [!WARNING]
> Bedrock Edition does not support SRV records. Bedrock players must enter the server IP and port separately when connecting, even if you have a custom domain.

## Using Root Domain

To use `yourdomain.com` (without a subdomain):

1. Set the A record Name to `@`
2. Set the SRV record Name to `_minecraft._tcp`

## Troubleshooting

### Domain not connecting

- Wait for DNS propagation (up to 24 hours)
- Verify the A record points to the correct IP
- Check that SRV record exists (for non-25565 ports)
- Disable Cloudflare proxy if enabled

### Connection refused

- Confirm your server is running
- Verify the port in your SRV record matches your server

### Works for some players, not others

- DNS propagation is still in progress
- Ask affected players to try flushing their DNS cache

## See Also

- [Bedrock Crossplay](/game-servers/minecraft/bedrock-crossplay)
- [Getting Started](/game-servers/minecraft/getting-started)
