---
title: Installing Modpacks
description: How to install pre-made or custom modpacks on your QualityNode Minecraft server.
order: 6
author: Brian Neumann-Fopiano
draft: true
---

# Installing Modpacks

QualityNode streamlines modpack installation through integration with CurseForge, Modrinth, and other platforms.

## Pre-Made Modpacks

### Installation Steps

1. Access your control panel and select your server
2. Navigate to the **Modpacks** tab in the sidebar
3. Browse available packs or search for specific ones
4. You can also paste a direct link to a modpack in the search bar
5. Click the install icon on your chosen pack
6. Select **Delete all files** for a fresh installation
7. Click confirm and wait for the installation to complete

<!-- TODO: Add screenshot of the Modpacks tab -->

> [!NOTE]
> Larger modpacks may take several minutes to install. Your server will be ready once the process completes.

### Supported Platforms

QualityNode supports modpacks from:
- CurseForge
- Modrinth
- Feed The Beast
- Technic
- Voids Wrath

### Client Requirements

Players must have the matching modpack installed via their launcher (CurseForge, Modrinth, Prism Launcher, etc.) to join your server.

## Custom Modpacks

Want to use your own modpack? Import from CurseForge or Modrinth apps.

### From CurseForge App

1. In the CurseForge app, open your modpack
2. Click the **Share Profile** button
3. Copy the generated share code
4. In your server's **Modpacks** tab, click **Install**
5. Paste the share code
6. Select **Delete all files** and confirm

### From Modrinth App

1. In the Modrinth app, export your modpack as a `.mrpack` file
2. In your server's **Modpacks** tab, click **Install**
3. Drag and drop the `.mrpack` file into the panel
4. Select **Delete all files** and confirm

## Updating Modpacks

To update an existing modpack to a newer version:

1. Follow the standard installation steps above
2. **Do NOT select "Delete all files"** to preserve your world and player data
3. Confirm the installation

> [!WARNING]
> Create a backup before updating. Modpack upgrades can occasionally cause world corruption, especially with major version changes.

After updating, make sure all players also update their client modpacks to the matching version.

## Troubleshooting

### Server won't start after modpack installation

- Check the console for error messages
- Ensure you have enough RAM allocated for the modpack
- Some modpacks require specific Java versions

### Players can't connect

- Verify players have the exact same modpack version
- Check that optional client-side mods aren't causing conflicts
- Review the server logs for connection errors

### Modpack not found

- Try pasting a direct link to the modpack page
- Some modpacks may not allow server distribution - check the modpack's licensing

## See Also

- [Uploading Mods and Plugins](/game-servers/minecraft/mods-plugins)
- [Choosing Server Software](/game-servers/minecraft/server-software)
- [Pre-installed Fabric Mods](/game-servers/minecraft/fabric-mods)
