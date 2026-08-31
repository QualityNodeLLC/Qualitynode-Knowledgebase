---
title: Download Your Backup
description: Download a complete backup of your server for safekeeping or migration.
order: 17
author: Brian Neumann-Fopiano
draft: true
---

# Download Your Backup

Download a complete backup of your Minecraft server for local storage or migration to another host.

## When to Download Backups

- Before canceling your hosting plan
- For off-site storage redundancy
- Migrating to another provider
- Testing on a local server
- Archiving completed projects

## Downloading a Full Server Backup

### Step 1: Stop Your Server

1. Go to your control panel and select your server
2. Click the **Stop** button

Stopping the server ensures all data is saved and prevents file corruption.

### Step 2: Create a Fresh Backup

1. Click **Backups** in the sidebar
2. Click **Create Backup**
3. Click **Create** to confirm

Wait for generation to complete. Processing time depends on server size (minutes for small servers, longer for large ones).

> [!NOTE]
> Backups are sent off-site for redundancy, which may add some processing time.

### Step 3: Download the Backup

1. Click the three-dot menu (&#8942;) next to your backup
2. Select **Download**

The download is a `.tar.gz` archive containing your entire server.

<!-- TODO: Add screenshot of backup download menu -->

## Extracting the Backup

### Windows

1. Download and install [7-Zip](https://7-zip.org/)
2. Right-click the `.tar.gz` file
3. Select **7-Zip** > **Extract Here**
4. Right-click the resulting `.tar` file
5. Select **7-Zip** > **Extract Here**

### Mac

Double-click the `.tar.gz` file. macOS extracts it automatically.

### Linux

```bash
tar -xzf backup-filename.tar.gz
```

## Downloading Only Your World

If you only need the world files:

1. Go to the **Files** tab in your panel
2. Right-click the `world` folder
3. Select **Download**

For Paper servers, also download:
- `world_nether`
- `world_the_end`

## Re-uploading Backups

### Small Backups (Under 10GB)

1. Extract the backup on your computer
2. Drag and drop files into the **Files** tab
3. Right-click and select **Unarchive** if needed

### Large Backups (Over 10GB)

1. Connect via [SFTP](/game-servers/minecraft/sftp)
2. Upload the extracted files
3. Use the web panel to extract any archives

## What's Included in Backups

A full backup contains:
- World folders (overworld, nether, end)
- Server configuration files
- Plugins/mods and their configs
- Player data (inventories, positions)
- Logs and other server files

## What's Not Included

- Database contents (separate MySQL backups needed)
- External resources (linked resource packs, etc.)

## Troubleshooting

### Download keeps failing

- Check your internet connection
- Try during off-peak hours
- Large backups may timeout - use SFTP instead

### Backup won't extract

- Try a different extraction tool
- Re-download the backup (may have corrupted)
- Verify you have enough disk space

### Missing files after extraction

- Ensure you extracted both `.tar.gz` and `.tar` layers
- Check for hidden files in the extracted folder

## See Also

- [Automatic Backups](/game-servers/minecraft/automatic-backups)
- [SFTP File Access](/game-servers/minecraft/sftp)
- [Upload a Custom World](/game-servers/minecraft/custom-world)
