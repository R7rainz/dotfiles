# Terminal Toggle Guide 🖥️

## Quick Toggle (Like VS Code!)

### Main Shortcut
- **`Ctrl + ` (backtick)`** - Toggle terminal (just like VS Code/Zed!)

### Alternative (if backtick doesn't work)
- **`Ctrl + \`** - Also toggles terminal

## How It Works

1. Press **`Ctrl + ` `** anywhere in your editor
2. Terminal opens at the bottom (30% height)
3. Press **`Ctrl + ` `** again to close it
4. Press it again to reopen - keeps your session!

## Different Terminal Layouts

### Horizontal Terminal (Bottom)
- **`Space + th`** - Terminal at bottom (30% height)

### Vertical Terminal (Side)
- **`Space + tv`** - Terminal on right side (40% width)

### Floating Terminal (Overlay)
- **`Space + tf`** - Floating terminal window

## Escape Terminal Mode

When you're in the terminal and want to get back to normal mode:

- **`Esc`** - Exit terminal mode
- **`jk`** - Also exits terminal mode (same as editor)

## Usage Examples

### Example 1: Quick Commands
```
1. Editing code in neovim
2. Press Ctrl+` → Terminal opens
3. Type: npm run dev
4. Press Ctrl+` → Back to editing
5. Terminal keeps running in background!
6. Press Ctrl+` → Terminal comes back
```

### Example 2: Split Screen Coding
```
1. Press Space+tv → Vertical terminal on right
2. Run: npm start
3. Edit code on left, see output on right
4. Press Esc to switch to terminal
5. Press Ctrl+w+w to switch between editor and terminal
```

### Example 3: Floating Terminal
```
1. Press Space+tf → Floating terminal appears
2. Run quick commands
3. Press Ctrl+` or Esc then :q to close
```

## Pro Tips

1. **Keep terminal session alive**
   - Terminal session persists when you toggle it
   - Close and reopen - your commands are still there!

2. **Multiple terminals**
   - Open horizontal: Space+th
   - Open vertical: Space+tv
   - Now you have 2 terminals!

3. **Navigate between editor and terminal**
   - Ctrl+w+w - Cycle through windows
   - Ctrl+w+h/j/k/l - Move to specific window

4. **Run and forget**
   - Start dev server with Ctrl+`
   - Close terminal with Ctrl+`
   - Server keeps running!
   - Toggle back anytime to check

## Quick Reference

| Shortcut | Action |
|----------|--------|
| `Ctrl + `` | Toggle terminal |
| `Ctrl + \` | Toggle terminal (alt) |
| `Space + th` | Horizontal terminal |
| `Space + tv` | Vertical terminal |
| `Space + tf` | Floating terminal |
| `Esc` | Exit terminal mode |
| `jk` | Exit terminal mode |

## Common Workflows

### Web Development
```
Ctrl+`              → Open terminal
npm run dev         → Start dev server
Ctrl+`              → Back to editing
(make changes)
Ctrl+`              → Check terminal output
```

### Git Workflow
```
Space+tv            → Vertical terminal
git status          → Check status
Esc                 → Back to normal mode
Ctrl+w+h            → Switch to editor
(make changes)
Ctrl+w+l            → Back to terminal
git add .
git commit -m "..."
```

### Testing
```
Space+tf            → Floating terminal
npm test            → Run tests
(keeps visible while you code)
```

## Remember

- **Ctrl+`** works from anywhere (normal mode or terminal mode)
- Terminal session persists when hidden
- Use **Esc** to exit terminal mode to normal vim mode
- Multiple terminals can be open at once!

Enjoy your VS Code-like terminal experience! 🚀
