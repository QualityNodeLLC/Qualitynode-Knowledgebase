---
title: Schedules and Tasks
description: Automate server maintenance with scheduled tasks.
icon: clock
order: 7
tags: [schedules, automation, tasks]
---

# Schedules and Tasks

Automate routine server maintenance with scheduled tasks.

## Creating a Schedule

1. Go to **Schedules** in your control panel
2. Click **Create Schedule**
3. Set the schedule name and timing
4. Add tasks to execute
5. Save and activate

## Schedule Timing

Set when your schedule runs:

- **Cron Expression** - Advanced timing control
- **Interval** - Run every X minutes/hours
- **Daily** - Run at a specific time each day
- **Weekly** - Run on specific days

### Cron Examples

```
# Every hour at minute 0
0 * * * *

# Daily at 4 AM
0 4 * * *

# Every 6 hours
0 */6 * * *

# Every Sunday at midnight
0 0 * * 0
```

## Task Types

### Power Actions
- **Start** - Start the server
- **Stop** - Stop the server
- **Restart** - Restart the server
- **Kill** - Force stop

### Command
Execute a console command:
```
say Server restarting in 5 minutes!
```

### Backup
Create an automatic backup.

## Common Schedules

### Daily Restart
Restart daily at 4 AM to maintain performance:

```yaml
Name: Daily Restart
Timing: 0 4 * * *
Tasks:
  1. Command: say Server restarting in 5 minutes
  2. Wait: 5 minutes
  3. Power: Restart
```

### Hourly Backup
Backup every hour:

```yaml
Name: Hourly Backup
Timing: 0 * * * *
Tasks:
  1. Backup
```

### Warning Before Restart
Warn players before scheduled restart:

```yaml
Name: Restart Warning
Timing: 55 3 * * *
Tasks:
  1. Command: say Server restart in 5 minutes
```

> [!TIP]
> Chain multiple tasks together. For example: warn players, wait, then restart.
