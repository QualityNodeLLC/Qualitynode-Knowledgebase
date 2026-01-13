---
title: Anticheat Options
description: Protect your server from cheaters with the right anticheat solution.
order: 28
author: Brian Neumann-Fopiano
---

# Anticheat Options

No anticheat is perfect, but choosing the right one significantly reduces cheating on your server.

## Important Principles

### Never Auto-Ban

> [!CAUTION]
> Configure anticheats to flag and notify, not automatically ban. False positives happen due to lag, high ping, client mods, or anticheat errors.

Staff should manually review flagged players before taking action.

### Single Anticheat Only

Run only one anticheat at a time. Multiple anticheats conflict with each other and cause more problems than they solve.

## Recommended Options

### Vulcan (Paid)

**Price:** One-time purchase on [SpigotMC](https://spigotmc.org/resources/vulcan-anti-cheat-advanced-cheat-detection.83626/)

The most reliable anticheat currently available with very low false positive rates.

**Features:**
- Detects movement, combat, and utility cheats
- Discord webhook integration for staff alerts
- User-friendly configuration
- Regular updates

**Best for:** Servers prioritizing accuracy over cost.

### Grim (Free)

**Download:** [SpigotMC](https://spigotmc.org/resources/grim-anticheat.99923/) or [GitHub](https://github.com/GrimAnticheat/Grim)

A highly effective free option using 1:1 player movement simulation.

**Features:**
- Accurately detects movement and combat cheats
- Simulates what players *should* be doing
- Discord webhook system
- Active development

**Best for:** Servers wanting strong protection without cost.

## Paper Anti-Xray

For survival servers, enable Paper's built-in Anti-Xray before adding other anticheats.

In `config/paper-world-defaults.yml`:

```yaml
anticheat:
  anti-xray:
    enabled: true
    engine-mode: 2
```

Engine mode 2 sends fake ores to clients, making x-ray ineffective.

## When Investigating Cheaters

Use these tools to verify before taking action:

### Check Server Health

```
spark tps
```

Low TPS can cause false positives from lag.

### Check Player Ping

High latency causes rubber-banding that anticheats may misinterpret.

### Review Context

- Are they using known client mods?
- Is the behavior consistent or occasional?
- Could lag explain the flags?

## Anticheat Configuration Tips

### Vulcan

- Start with default settings
- Gradually tighten detection thresholds based on your server's behavior
- Enable Discord webhooks for real-time alerts

### Grim

- Configure `max-ping` to account for your player base
- Review predictions settings for your server's typical TPS
- Set up Discord alerts for high-violation players

## What Anticheats Detect

| Cheat Type | Detection |
|------------|-----------|
| Speed/fly hacks | High accuracy |
| Kill aura | Moderate-high accuracy |
| Reach/hitbox | Moderate accuracy |
| Auto-clickers | Lower accuracy |
| X-ray | Requires Anti-Xray |

## Limitations

Anticheats cannot reliably detect:
- Texture pack x-ray (use Anti-Xray engine)
- Minimaps with radar
- Client-side information mods
- Very subtle modifications

## See Also

- [Uploading Mods and Plugins](/game-servers/minecraft/mods-plugins)
- [Diagnosing Server Lag](/game-servers/minecraft/diagnosing-lag)
