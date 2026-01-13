---
title: MySQL Databases
description: Set up shared databases for cross-server data synchronization.
order: 24
author: Brian Neumann-Fopiano
---

# MySQL Databases

Databases enable plugins to store and share player data across multiple servers, essential for networks with shared inventories, permissions, or economy.

## Common Use Cases

- **LuckPerms** - Synchronized permissions across servers
- **CoreProtect** - Centralized block logging
- **CMI/EssentialsX** - Shared economy and player data
- **Custom plugins** - Any plugin supporting MySQL storage

## Creating a Database

### Step 1: Access Database Settings

1. Go to your control panel and select your server
2. Click **Databases** in the sidebar
3. Click **Create Database**

### Step 2: Name Your Database

Choose a descriptive name reflecting its purpose:
- `luckperms`
- `coreprotect`
- `economy`

Leave the "Connections From" field blank and confirm creation.

### Step 3: View Credentials

Click the eye icon next to your database to reveal connection details:

- **Host/Address**
- **Port**
- **Database Name**
- **Username**
- **Password**

## Configuring Plugins

### Connection Details

When configuring plugins, use these settings:

| Setting | Value |
|---------|-------|
| **Address** | `172.18.0.1` |
| **Port** | `3306` (usually default) |
| **Database** | Your database name (e.g., `s123_luckperms`) |
| **Username** | As shown in panel |
| **Password** | As shown in panel |

> [!NOTE]
> Use the internal IP `172.18.0.1` for direct server connections within QualityNode's network. This provides faster, more reliable connectivity.

### Storage Type

When prompted for storage type, select:
- **MariaDB** (preferred - it's what QualityNode runs)
- **MySQL** (compatible alternative)
- **SQL** (if only option available)

### Quick Configuration

The panel offers quick-copy buttons for common plugins like LuckPerms and CoreProtect. These pre-fill the configuration with your database credentials.

## Example: LuckPerms Configuration

In `plugins/LuckPerms/config.yml`:

```yaml
storage-method: MariaDB

data:
  address: 172.18.0.1:3306
  database: s123_luckperms
  username: u123_abc
  password: your_password_here
  pool-settings:
    maximum-pool-size: 10
```

## Example: CoreProtect Configuration

In `plugins/CoreProtect/config.yml`:

```yaml
use-mysql: true
mysql-host: 172.18.0.1
mysql-port: 3306
mysql-database: s123_coreprotect
mysql-username: u123_abc
mysql-password: your_password_here
```

## Managing Databases Externally

Access your database from your computer using database management tools:

### Recommended Software

- [HeidiSQL](https://heidisql.com/) (Windows)
- [MySQL Workbench](https://mysql.com/products/workbench/) (Cross-platform)
- [DBeaver](https://dbeaver.io/) (Cross-platform)

### External Connection

When connecting from outside QualityNode's network, use the external address shown in your panel (not `172.18.0.1`).

## Multiple Servers, One Database

For networks with shared data:

1. Create one database for each plugin that needs sharing
2. Configure all servers to use the same database credentials
3. Ensure plugins support multi-server mode (most do)

## Troubleshooting

### Connection refused

- Verify the address is `172.18.0.1` for internal connections
- Check credentials are copied exactly
- Ensure the database exists

### Access denied

- Double-check username and password
- Verify the database name matches exactly
- Recreate the database if issues persist

### Slow performance

- Use MariaDB driver if available
- Check pool settings in plugin configuration
- Monitor database size for bloat

## See Also

- [Velocity Proxy Setup](/game-servers/minecraft/velocity-proxy)
- [Uploading Mods and Plugins](/game-servers/minecraft/mods-plugins)
