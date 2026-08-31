---
title: Automatic Backups
description: Schedule regular automated backups to protect your server data.
order: 16
author: Brian Neumann-Fopiano
draft: true
---

# Automatic Backups

Configure automatic daily backups to protect your world, configurations, and player data.

## Why Backup Automatically?

Backups protect against:
- Accidental file deletion
- World corruption
- Failed updates
- Griefing damage
- Hardware failures

Automated backups ensure protection even if you forget to create them manually.

## Setting Up Automatic Backups

### Step 1: Access the Control Panel

Go to your control panel and select your server.

### Step 2: Configure Time Zone

1. Click **Settings** in the sidebar
2. Set your server's time zone

This ensures backups run at the expected local time.

### Step 3: Create a Schedule

1. Click **Schedules** in the sidebar
2. Click **Create Schedule**

### Step 4: Configure Schedule Details

| Field | Recommendation |
|-------|----------------|
| Name | "Daily backup" |
| Preset | "Every day at 06:00" |
| Hour | Adjust to your preferred time |

Click **Create Schedule** to save.

### Step 5: Add Backup Task

1. Click on your newly created schedule
2. Click **Create Task**
3. Set **Action** to "Create backup"
4. Click **Create Task**

<!-- TODO: Add screenshot of the backup task configuration -->

## Backup Timing Recommendations

| Server Type | Frequency | Time |
|-------------|-----------|------|
| Low activity | Daily | Early morning (3-6 AM) |
| Active community | Twice daily | Morning and evening |
| Event servers | Before each event | + scheduled daily |

> [!TIP]
> Schedule backups during low-activity hours to minimize impact on players.

## Backup Limits

The scheduling system limits automated backups to **5 per day**. This prevents storage overuse while ensuring adequate protection.

For more frequent backups:
- Use in-game backup plugins
- Create manual backups before major changes

## Combining with Restarts

Create a backup before each automatic restart for maximum safety:

1. Create a schedule for your restart time
2. Add a "Create backup" task at offset `0`
3. Add warning messages
4. Add the restart task with appropriate offset

This ensures you always have a backup from immediately before each restart.

## Manual Backups

In addition to automated backups:

1. Go to the **Backups** section in your panel
2. Click **Create Backup**
3. Wait for generation to complete

Create manual backups before:
- Server software updates
- Major world changes
- Installing new mods/plugins
- Modpack updates

## Backup Storage

Access available backups through the **Backups** section of the panel.

View backup details:
- Creation timestamp
- File size
- Download option
- Restore option

## See Also

- [Download Your Backup](/game-servers/minecraft/download-backup)
- [Automatic Restarts](/game-servers/minecraft/automatic-restarts)
