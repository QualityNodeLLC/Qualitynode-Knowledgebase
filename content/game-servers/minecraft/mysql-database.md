---
title: MySQL Databases
description: Configure a plugin with database credentials displayed by the server panel.
order: 24
author: Brian Neumann-Fopiano
---

# MySQL Databases

The current plan configuration includes MySQL Database on Performance and
Unlimited MySQL on Enterprise. Confirm the feature in the billing portal and
server panel for your subscription.

## Create a database

When the server panel shows a **Databases** section:

1. Open that section for the server that will use the database.
2. Create a database with a purpose-specific name.
3. Reveal the connection values generated for that database.
4. Store the password in the plugin configuration or secret mechanism required
   by that plugin.

## Configure a plugin

Copy every connection value from the database entry shown in the panel:

| Plugin setting | Source |
|----------------|--------|
| Host or address | Database entry in the panel |
| Port | Database entry in the panel |
| Database name | Database entry in the panel |
| Username | Database entry in the panel |
| Password | Database entry in the panel |

Do not substitute a fixed private address, a value from another server, or an
example credential. Plugin field names and supported database drivers are
defined by the plugin's own documentation.

## Troubleshooting

- Recopy the host, port, database name, and username from the same database
  entry.
- Reset the database password in the panel and update the plugin configuration
  when credentials may have been exposed.
- Confirm the plugin supports the database type offered by the panel.
- Review the plugin log for the exact connection error before changing network
  or pool settings.

If the database section or required action is unavailable, email
support@qualitynode.net with the server identifier. Do not send the database
password.

## See also

- [Velocity Proxy Setup](/game-servers/minecraft/velocity-proxy)
- [Minecraft Guides](/game-servers/minecraft)
