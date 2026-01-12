---
title: File Management
description: Navigate and manage your server files using the built-in file manager.
icon: folder
order: 5
tags: [files, config, upload]
---

# File Management

The built-in file manager lets you browse, edit, and manage all your server files.

## Accessing the File Manager

1. Select your server from the dashboard
2. Click **Files** in the sidebar
3. Browse your server's file system

## Common Operations

### Uploading Files
1. Navigate to the destination folder
2. Click **Upload** or drag files into the browser
3. Wait for upload to complete

### Editing Files
1. Click on a file to open it
2. Make your changes in the editor
3. Click **Save** or press `Ctrl+S`

### Creating Files/Folders
1. Click **New File** or **New Folder**
2. Enter the name
3. Click **Create**

### Downloading Files
1. Right-click the file
2. Select **Download**
3. File downloads to your computer

### Deleting Files
1. Right-click the file or folder
2. Select **Delete**
3. Confirm deletion

> [!WARNING]
> Deleted files cannot be recovered unless you have a backup.

## Important File Locations

| Game | Config File | Location |
|------|-------------|----------|
| Minecraft | server.properties | `/server.properties` |
| Rust | server.cfg | `/server/rustserver/cfg/` |
| ARK | GameUserSettings.ini | `/ShooterGame/Saved/Config/` |
| Valheim | Start parameters | Control panel settings |

## SFTP Access

For bulk file transfers, use SFTP:

1. Go to **Settings** in your control panel
2. Find your SFTP credentials
3. Connect using an SFTP client (FileZilla, WinSCP)

```
Host: Your server address
Port: 2022 (typically)
Username: Your panel username
Password: Your panel password
```

## File Editor Features

The built-in editor supports:
- Syntax highlighting
- Line numbers
- Find and replace
- Multiple file tabs
- Auto-save drafts
