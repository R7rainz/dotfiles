# Neovide Enhanced Configuration 🚀

## Visual Enhancements

### 🎨 Cursor Effects
- **Railgun VFX Mode** - Awesome particle effects following cursor
- **Smooth animations** - Cursor animates smoothly in insert mode and command line
- **Trail effect** - Beautiful cursor trail with 0.8 opacity
- **Antialiasing** - Smooth, crisp cursor rendering

### 🪟 Window Effects
- **Transparency** - Subtle 95% opacity for modern look
- **Floating blur** - Blurred background for floating windows
- **Shadow effects** - Floating windows have depth with shadows
- **Padding** - 10px padding on all sides for breathing room

### 🎯 Smooth Scrolling
- **Animated scrolling** - Buttery smooth scroll animations (0.3s)
- **Far line optimization** - Special handling for long scrolls

## Performance Settings

- **60 FPS refresh rate** when active
- **5 FPS idle rate** to save battery
- **No idle mode** - Keeps animations smooth
- **Confirm quit** - Prevents accidental closes

## 🎹 Keyboard Shortcuts

### Zoom Controls
- **Ctrl + =** - Zoom in (increase scale by 10%)
- **Ctrl + -** - Zoom out (decrease scale by 10%)
- **Ctrl + 0** - Reset zoom to 100%

### Window Controls
- **F11** - Toggle fullscreen mode

## Enhanced Editing Features

### Line Numbers
- **Relative numbers** - Easier to jump around with counts
- **Wide number column** - Better spacing

### Better Visibility
- **Cursorline** - Highlights current line
- **Sign column always visible** - Consistent gutter
- **Scrolloff 8** - Keep 8 lines visible above/below cursor

### Splits
- **Vertical split right** - New splits open on right
- **Horizontal split below** - New splits open below

### Search
- **Smart case** - Case-insensitive unless you use caps
- **Ignorecase** - Default case-insensitive search

### Completion
- **Pumheight 15** - Show 15 completion items max
- **Pumblend 10** - Slight transparency in completion menu

### System Integration
- **System clipboard** - Yank/paste works with Ctrl+C/V
- **Mouse support** - Full mouse integration
- **Undo persistence** - Undo history saved between sessions

### Performance
- **No swap files** - Faster, no clutter
- **Fast completion** - 250ms update time
- **Quick timeout** - 300ms for key sequences

## 🎨 Font

Default font: **JetBrainsMono Nerd Font** at size 12

To change font, edit `init.lua`:
```lua
vim.o.guifont = "YourFont:h12"
```

## Tips

1. **First time opening?** Font may not be perfect - adjust with Ctrl+= or Ctrl+-
2. **Too transparent?** Adjust `vim.g.neovide_transparency` (0.0 to 1.0)
3. **Cursor too fast?** Increase `vim.g.neovide_cursor_animation_length`
4. **Want more effects?** Try changing cursor VFX:
   - `railgun` (current)
   - `torpedo`
   - `pixiedust`
   - `sonicboom`
   - `ripple`
   - `wireframe`

## Troubleshooting

### Font not found?
Install JetBrainsMono Nerd Font:
```bash
# On Arch/Manjaro
sudo pacman -S ttf-jetbrains-mono-nerd

# Or download from: https://www.nerdfonts.com/
```

### Animations too slow/fast?
Adjust in `init.lua`:
```lua
vim.g.neovide_scroll_animation_length = 0.3  -- Lower = faster
vim.g.neovide_cursor_animation_length = 0.08 -- Lower = snappier
```

### Want no transparency?
```lua
vim.g.neovide_transparency = 1.0
```

## All Together

These settings create a beautiful, modern, high-performance neovim experience in Neovide with:
- ✨ Smooth animations
- 🎨 Beautiful effects
- ⚡ Fast performance
- 🎯 Better editing experience
- 🎹 Convenient shortcuts

Enjoy! 🚀
