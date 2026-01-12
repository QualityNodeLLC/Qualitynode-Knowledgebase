---
title: Backups
description: Protect your server data with automatic and manual backups.
icon: hard-drive
order: 3
tags: [backups, data, restore]
---

# Server Backups

Regular backups protect your server data from loss, corruption, or mistakes.

## Backup Types

### Automatic Backups
Your plan includes automatic backups:

| Plan | Backup Frequency | Retention |
|------|-----------------|-----------|
| Threshold | Daily | 3 days |
| Agent | Hourly | 7 days |
| Director | Real-time | 14 days |
| Astral | Continuous | 30 days |

### Manual Backups
Create backups on-demand:

1. Go to **Backups** in your control panel
2. Click **Create Backup**
3. Wait for completion
4. Backup appears in your list

## Creating a Backup

```
1. Navigate to your server panel
2. Click "Backups" in the sidebar
3. Click "Create Backup" button
4. Optional: Add a note (e.g., "Before mod update")
5. Wait for backup to complete
```

> [!TIP]
> Always create a manual backup before making major changes like updating mods or changing configurations.

## Restoring a Backup

1. Go to **Backups** in your control panel
2. Find the backup you want to restore
3. Click **Restore**
4. Confirm the restoration
5. Wait for the process to complete

> [!WARNING]
> Restoring a backup will overwrite current server data. Create a backup of your current state first if needed.

## Downloading Backups

Keep copies of your backups locally:

1. Find the backup in your list
2. Click the **Download** button
3. Save the archive to your computer

## Best Practices

- Create manual backups before updates
- Test restores periodically
- Keep local copies of important backups
- Document what each backup contains
