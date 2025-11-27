# 🚀 Fast Navigation & Editing Cheat Sheet

## 🎯 Multi-Cursor (Like VS Code)
- `Ctrl+d` - Select word under cursor, press again to select next occurrence (like VS Code!)
- `Ctrl+x` - Skip current selection and jump to next
- `Ctrl+p` - Remove current cursor/selection
- `<leader>ma` - Select all occurrences
- `Tab` - Switch between cursor and extend mode
- `Esc` - Exit multi-cursor mode

### Multi-cursor Usage:
1. Place cursor on a word
2. Press `Ctrl+d` to select it
3. Press `Ctrl+d` again to select next occurrence (keep pressing!)
4. Start typing to change all at once
5. Press `Esc` when done

## 🏃 Super Fast Navigation

### Line Movements
- `H` - Jump to start of line (first non-blank)
- `L` - Jump to end of line
- `0` - Jump to very beginning of line
- `^` - Jump to first non-blank character
- `$` - Jump to end of line

### Page Scrolling (Auto-centered!)
- `Ctrl+d` - Scroll half page down (cursor stays centered)
- `Ctrl+u` - Scroll half page up (cursor stays centered)
- `{` - Jump to previous paragraph/empty line
- `}` - Jump to next paragraph/empty line

### Word Jumping
- `w` - Next word start
- `b` - Previous word start
- `e` - Next word end
- `W` - Next WORD (ignore punctuation)
- `B` - Previous WORD

### Search Navigation (Auto-centered!)
- `n` - Next search result (centered)
- `N` - Previous search result (centered)
- `*` - Search word under cursor forward
- `#` - Search word under cursor backward

### Flash Navigation (Super Fast!)
- `<leader>s` - Flash jump to any visible text
- `<leader>S` - Flash jump to treesitter nodes (functions, classes, etc.)
- `f{char}` - Find character forward (enhanced with flash)
- `F{char}` - Find character backward

## 🎪 Jump to Empty Brackets/Functions
- `<leader>jb` - Jump into next empty bracket {} [] ()
- `<leader>jf` - Jump into next empty function
- `%` - Jump to matching bracket/brace (centered)

## 📝 Smart Editing

### Visual Mode Selection
- `V` - Select entire line
- `viw` - Select word under cursor
- `vi{` - Select inside {}
- `vi(` - Select inside ()
- `vi[` - Select inside []
- `vi"` - Select inside ""
- `vi'` - Select inside ''
- `vit` - Select inside HTML tag

### Move Lines (Like VS Code!)
In Visual Mode:
- `J` - Move selected lines down
- `K` - Move selected lines up

### Surround Text (mini.surround)
- `sa{motion}{char}` - Add surrounding (e.g., `saiw"` = surround word with ")
- `sd{char}` - Delete surrounding (e.g., `sd"` = delete surrounding ")
- `sr{old}{new}` - Replace surrounding (e.g., `sr"'` = replace " with ')

Examples:
- `saiw"` - Surround current word with quotes
- `sa$)` - Surround to end of line with parentheses
- `sd"` - Delete surrounding quotes
- `sr"'` - Change " to '

### Better Indenting
In Visual Mode:
- `>` - Indent right (stays in visual mode)
- `<` - Indent left (stays in visual mode)

### Copy/Paste/Delete
- `p` - Paste (in visual mode, doesn't overwrite register)
- `<leader>d` - Delete without yanking (doesn't pollute register)
- `yy` - Yank (copy) entire line
- `dd` - Delete entire line

## 🔄 Search & Replace
- `<leader>rw` - Replace word under cursor in entire file
- `:%s/old/new/g` - Replace all occurrences
- `:%s/old/new/gc` - Replace with confirmation

## 🎯 Mini.bracketed Navigation (Prefix [ and ])
- `]c` / `[c` - Next/previous comment
- `]d` / `[d` - Next/previous diagnostic (error/warning)
- `]t` / `[t` - Next/previous treesitter node (function/class)
- `]b` / `[b` - Next/previous buffer
- `]q` / `[q` - Next/previous quickfix item

## 🔢 Numbers & Quick Actions
- `+` - Increment number under cursor
- `-` - Decrement number under cursor
- `Ctrl+a` - Select all text
- `Ctrl+s` - Save file

## 📍 Relative Line Numbers (Already Enabled!)
Jump fast with:
- `15j` - Jump 15 lines down
- `10k` - Jump 10 lines up
- `5gg` or `:5` - Jump to line 5

## 🎨 Your Existing Keybindings
- `<leader>s` - Flash jump (super fast!)
- `<leader>S` - Flash treesitter
- `Tab` - Next buffer
- `Shift+Tab` - Previous buffer
- `<leader>x` - Close buffer
- `Ctrl+h/j/k/l` - Navigate between windows
- `Ctrl+` ` - Toggle terminal
- `-` - Open Oil file manager

## 💡 Pro Tips

### Workflow Example 1: Rename Variable
1. Place cursor on variable name
2. Press `Ctrl+d` multiple times to select all occurrences
3. Type new name
4. Press `Esc`

### Workflow Example 2: Jump to Empty Function & Start Typing
1. Press `<leader>jf` to jump to next empty function
2. Start typing immediately!

### Workflow Example 3: Fast Navigation
1. Press `<leader>s` for flash
2. Type 2 characters of where you want to go
3. Press the highlighted letter
4. You're there!

### Workflow Example 4: Change Surrounding Quotes
1. Cursor on text inside quotes: `"hello"`
2. Press `sr"'`
3. Result: `'hello'`

## 🔥 Muscle Memory Practice Order
1. Start with: `Ctrl+d` (multi-cursor)
2. Then learn: `<leader>s` (flash jump)
3. Then add: `H` and `L` (line start/end)
4. Then use: `Ctrl+d/u` (page scroll)
5. Finally: Mini.surround and brackets

---
**Remember**: With `scrolloff=8`, your cursor always stays 8 lines from the edge!
