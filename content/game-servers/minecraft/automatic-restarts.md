---
title: Automatic Restarts
description: Schedule regular server restarts to maintain performance and stability.
order: 15
author: Brian Neumann-Fopiano
draft: true
---

# Automatic Restarts

Scheduling regular server restarts helps maintain stability by clearing RAM. This is particularly beneficial for heavily modded servers.

## Why Restart Regularly?

Over time, servers accumulate:
- Memory leaks from mods/plugins
- Cached data that isn't properly cleared
- Entity buildup

Regular restarts clear this buildup and keep your server running smoothly.

## Setting Up Automatic Restarts

### Step 1: Access the Control Panel

Go to your control panel and select your server.

### Step 2: Configure Time Zone

1. Click **Settings** in the sidebar
2. Set your server's time zone

This ensures schedules run at the expected times and console timestamps are accurate.

### Step 3: Create a Schedule

1. Go to the **Schedules** tab
2. Click **Create Schedule**
3. Name it (e.g., "Daily restart")
4. Configure the timing:
   - Select "Every day at 06:00" for a preset
   - Or customize the hour field as needed

<!-- TODO: Add screenshot of the schedule creation interface -->

### Step 4: Add the Restart Task

1. Click on your newly created schedule
2. Click **Create Task**
3. Set **Action** to "Send power action"
4. Under **Payload**, choose "Restart the server"
5. Click **Create Task**

## Adding Player Warnings

Warn players before the restart so they don't lose progress:

### Create Warning Task

1. In your schedule, click **Create Task**
2. Set **Action** to "Send command"
3. Set **Payload** to:
   ```
   say Server will restart in 3 minutes!
   ```
4. Set **Time offset** to `0`
5. Click **Create Task**

### Adjust Restart Timing

1. Edit your restart task
2. Set **Time offset** to `180` (3 minutes in seconds)

Now the warning appears first, followed by the restart 3 minutes later.

### Multiple Warnings

For a better experience, add multiple warnings:

| Offset | Command |
|--------|---------|
| 0 | `say Server will restart in 5 minutes!` |
| 120 | `say Server will restart in 3 minutes!` |
| 240 | `say Server will restart in 1 minute!` |
| 290 | `say Server restarting in 10 seconds...` |
| 300 | (Restart action) |

## Recommended Restart Frequency

| Server Type | Frequency |
|-------------|-----------|
| Vanilla/light plugins | Every 24-48 hours |
| Moderate mods | Every 12-24 hours |
| Heavy modpacks | Every 6-12 hours |

> [!TIP]
> Schedule restarts during low-activity hours (early morning) to minimize player disruption.

## Combining with Backups

Create a backup before each restart for maximum safety:

1. Add a "Create backup" task at offset `0`
2. Add warning messages
3. Add the restart task with appropriate offset

The schedule system limits backups to 5 per day to prevent storage issues.

## See Also

- [Automatic Backups](/game-servers/minecraft/automatic-backups)
- [Diagnosing Server Lag](/game-servers/minecraft/diagnosing-lag)
