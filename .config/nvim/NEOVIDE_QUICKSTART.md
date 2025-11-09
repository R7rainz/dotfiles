# Neovide Quick Start Guide 🎨

## Instant Improvements You'll Notice

### 1. Beautiful Cursor 🎯
- Railgun particle effects following your cursor
- Smooth animations as you move
- Trail effect that looks amazing

### 2. Modern UI 🪟
- Slight transparency (95%) for sleek look
- Floating windows have blur and shadows
- Comfortable padding around edges

### 3. Smooth Scrolling 📜
- Buttery smooth scroll animations
- No more jarring jumps

### 4. Better Editing 📝
- Relative line numbers (easier to jump)
- Current line highlighted
- Smart search
- System clipboard works!

## Try These Now! 🎹

Press these keys in Neovide:

- **Ctrl + =** → Make text bigger
- **Ctrl + -** → Make text smaller  
- **Ctrl + 0** → Reset to normal size
- **F11** → Fullscreen mode

## Change Cursor Effects 🎨

Want different cursor effects? Edit `init.lua` and change:

```lua
vim.g.neovide_cursor_vfx_mode = "railgun"
```

Try these instead:
- `"torpedo"` - Underwater trail effect
- `"pixiedust"` - Sparkly fairy dust
- `"sonicboom"` - Speed lines
- `"ripple"` - Water ripples
- `"wireframe"` - Geometric shapes

## Adjust Transparency 

Don't like the transparency? Edit `init.lua`:

```lua
vim.g.neovide_transparency = 1.0  -- No transparency
-- or
vim.g.neovide_transparency = 0.8  -- More transparent
```

## That's It!

Just open Neovide and enjoy! Everything is configured and ready to use. 🚀

See **NEOVIDE_FEATURES.md** for the complete feature list!
