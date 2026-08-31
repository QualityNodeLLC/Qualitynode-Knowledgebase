---
title: Custom Domains
description: Point a domain name to a Minecraft server when the feature is available on your plan.
order: 18
author: Brian Neumann-Fopiano
draft: true
---

# Custom Domains

The current plan configuration includes Custom Subdomain on Standard and Custom
Domain on Performance and Enterprise. Confirm availability in the billing portal
and server panel before changing DNS.

## DNS Records

Use the server address and port shown in your panel. Do not copy an address from
another server or from an example.

For a standard Java Edition port, create an A or AAAA record for the host name.
For a nonstandard port, also create the Minecraft SRV record required by your
DNS provider:

| Field | Value |
|-------|-------|
| Service | `_minecraft` |
| Protocol | `_tcp` |
| Port | Port shown in the server panel |
| Target | Host name that resolves to the server address |

Keep any game-server record in DNS-only mode when the DNS provider's HTTP proxy
does not support Minecraft traffic.

<!-- TODO: Add a verified panel and DNS-provider example using nonproduction values. -->

## Verify

1. Confirm the host name resolves to the address shown in the server panel.
2. Confirm the SRV record uses the displayed port when one is required.
3. Wait for the DNS record's configured TTL before treating an old answer as a
   configuration failure.

## See Also

- [Server Properties](/game-servers/minecraft/server-properties)
- [Commands and Permissions](/game-servers/minecraft/commands)
