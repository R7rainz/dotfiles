# Alpha-nvim Welcome Screen - Usage Guide

## 🚀 Quick Start

Just open nvim or neovide without any arguments:
```bash
nvim
# or
neovide
```

## 📋 Available Options

Press the letter key to activate:

- **f** -  Find File (search files in current directory)
- **n** -  New File (create a new empty file)
- **r** -  Recent Files (open recently used files)
- **g** -  Find Text (search text across all files)
- **p** -  Open Project (browse and open folders)
- **c** -  Configuration (edit nvim config)
- **q** -  Quit (exit nvim)

## 📁 How to Open a Project/Folder

1. Press **p** from the welcome screen
2. Telescope opens showing folders in your home directory
3. Type to **fuzzy search** folders (e.g., type "backend" to find backend-learning)
4. Navigate with **arrow keys** or keep typing to filter
5. Press **Enter** to select a folder
6. **Oil file browser** opens showing the folder structure
7. Now you can:
   - Browse files with arrow keys
   - Press Enter to open a file
   - Press `-` to go up a directory
   - Or use `<Space>f` to fuzzy find files in that project

### Tips:
- The search looks through your home directory up to 4 levels deep
- Type any part of the folder name to filter (fuzzy search!)
- Excludes hidden folders, node_modules, and .git
- Once in Oil, you get a clear tree view of all files

## 🎨 Features

- ✨ Beautiful RAINZ ASCII art header with blue gradient
- 🎯 Color-coded shortcuts (red) and buttons (white)
- 📊 Shows plugin count, date, and neovim version
- 🌈 Better icon visibility and spacing
- ⚡ Fast telescope fuzzy finder for folders
- 📂 Opens in Oil for clear folder structure view

## 🔑 Keyboard Shortcuts in Oil

Once you've opened a project:
- **Enter** - Open file/directory
- **-** - Go to parent directory
- **<Space>f** - Find files (Telescope)
- **<Space>e** - Toggle file explorer
- **g?** - Show all Oil keybindings

## 💡 Pro Tips

- Use **Telescope** (p key) to quickly jump to any project
- Once in a project, **Oil** gives you a clean file tree
- You can still use `<Space>f` anytime to fuzzy find files
- The welcome screen only shows when you open nvim/neovide without arguments
