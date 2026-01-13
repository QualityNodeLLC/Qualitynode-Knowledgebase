---
title: SFTP File Access
description: Manage your server files from your computer using SFTP.
order: 20
author: Brian Neumann-Fopiano
---

# SFTP File Access

SFTP (Secure File Transfer Protocol) lets you manage server files directly from your computer, useful for uploading large files or bulk transfers.

## When to Use SFTP

- Uploading files larger than 10GB
- Bulk file transfers
- Using familiar desktop file management
- Editing files with your preferred editor

## Recommended SFTP Clients

### WinSCP (Windows)

Feature-rich and reliable. [Download WinSCP](https://winscp.net/)

### FileZilla (Cross-platform)

Popular and works on Windows, Mac, and Linux. [Download FileZilla](https://filezilla-project.org/)

> [!CAUTION]
> CyberDuck may have compatibility issues with QualityNode's SFTP server. Use WinSCP or FileZilla for best results.

## Getting Connection Details

### Step 1: Access Your Control Panel

Go to your control panel and select your server.

### Step 2: Find SFTP Details

1. Click the **Files** tab
2. Click **"SFTP Details"** in the upper right corner

This displays:
- Server/Host address
- Port (usually `2023`)
- Username

### Step 3: Your Password

> [!NOTE]
> Your SFTP password is your game panel password, which may differ from your billing password. If you need to reset it, log out and use the password recovery option.

## Connecting with Your SFTP Client

### Configure Connection Settings

| Setting | Value |
|---------|-------|
| **Protocol** | SFTP (not FTP or FTPS) |
| **Host** | Address from your panel |
| **Port** | `2023` (or as shown in panel) |
| **Username** | As shown in panel |
| **Password** | Your game panel password |

<!-- TODO: Add screenshot of SFTP client configuration -->

### First Connection

1. Enter your connection details
2. Click Connect
3. Accept the server's host key if prompted
4. You'll see your server's file system

## Transferring Files

### Upload

Drag files from your computer to the server file list, or use right-click > Upload.

### Download

Drag files from the server to your computer, or use right-click > Download.

### Navigate

Your SFTP client shows your server's root directory. Common locations:
- `/mods` - Mod files (Fabric/Forge)
- `/plugins` - Plugin files (Paper)
- `/world` - World data
- `/config` - Configuration files

## Quick Reconnection

Most SFTP clients save connection history:

- **WinSCP:** Sessions panel
- **FileZilla:** Site Manager or Quickconnect history

Save your connection as a site/session for one-click access.

## Large File Uploads

For files over 10GB:

1. Upload via SFTP (not the web panel)
2. If uploading a `.zip` file, extract it using the web panel's file manager after upload

## Troubleshooting

### Connection refused

- Verify you're using SFTP (not FTP)
- Check the port is `2023` or as specified
- Ensure the host address is correct

### Authentication failed

- Password is your game panel password (not billing)
- Try resetting your password via the login page

### Slow transfers

- Large files take time - check transfer progress
- Close other applications using bandwidth
- Try connecting during off-peak hours

### Permission denied

- Some system files are protected
- You have full access to game-related directories

## See Also

- [Upload a Custom World](/game-servers/minecraft/custom-world)
- [Download Your Backup](/game-servers/minecraft/download-backup)
