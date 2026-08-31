---
title: Upload a Custom World
description: How to upload and use your own world files on your Minecraft server.
order: 11
author: Brian Neumann-Fopiano
draft: true
---

# Upload a Custom World

Use your own world files on your QualityNode Minecraft server, whether from singleplayer, another server, or a downloaded adventure map.

## Step 1: Stop Your Server

1. Go to your control panel and select your server
2. Click the **Stop** button to shut down the server

> [!IMPORTANT]
> Always stop your server before modifying world files to prevent corruption.

## Step 2: Remove Existing Worlds

1. Click the **Files** tab in the sidebar
2. Delete the current `world` folder

For Paper-based servers, also remove:
- `world_nether`
- `world_the_end`

## Step 3: Prepare Your World

If your world is a folder (not a `.zip` file), compress it first:

**Windows:** Right-click the folder > Send to > Compressed (zipped) folder

**Mac:** Right-click the folder > Compress

> [!TIP]
> Compressing your world speeds up the upload process and ensures files transfer correctly.

## Step 4: Upload and Extract

1. In the **Files** tab, drag and drop your `.zip` file
2. Wait for the upload to complete
3. Right-click the uploaded `.zip` file
4. Select **Unarchive**
5. Rename the extracted folder to `world` if needed

<!-- TODO: Add screenshot of the file extraction process -->

## Step 5: Start Your Server

Click **Start** to boot your server with the new world.

## Large World Uploads

For worlds exceeding 10GB or if you experience upload issues:

1. Use [SFTP](/game-servers/minecraft/sftp) to upload the files
2. Extract through the panel's file manager after upload

## Where to Find Custom Worlds

| Source | Type |
|--------|------|
| [Minecraft-Maps.com](https://minecraft-maps.com) | Adventure maps |
| [CurseForge Worlds](https://curseforge.com/minecraft/worlds) | Various maps |
| [Planet Minecraft](https://planetminecraft.com/projects) | Community projects |

## Troubleshooting

### World not loading

- Verify the folder is named exactly `world`
- Check the world is compatible with your Minecraft version
- Ensure `level-name=world` in server.properties

### Missing Nether/End

For Paper servers, the dimensions are in separate folders. Upload:
- `world_nether` (or `DIM-1` folder inside world)
- `world_the_end` (or `DIM1` folder inside world)

### Spawn point incorrect

Use the command in-game or console:
```
setworldspawn <x> <y> <z>
```

## See Also

- [Reset Your World](/game-servers/minecraft/reset-world)
- [SFTP File Access](/game-servers/minecraft/sftp)
- [Download Your Backup](/game-servers/minecraft/download-backup)
