# 🚀 LazyVim Configuration

A modern, feature-rich Neovim configuration built on [LazyVim](https://www.lazyvim.org/) with support for multiple programming languages, elegant UI enhancements, and powerful development tools.

## ✨ Features

- **LazyVim Foundation**: Built on the excellent LazyVim starter template with intelligent lazy-loading
- **Multi-Language Support**: First-class support for Python, Go, Java, TypeScript, and Web development
- **Neovide Ready**: Fully optimized for [Neovide](https://neovide.dev/) GUI with smooth cursor animations and visual enhancements
- **Beautiful UI**: Modern colorschemes with Rosepine Moon as the default, customizable themes
- **Powerful Tools**: Integrated development utilities including Docker support, Linux tools, and more
- **Smart Completion**: Blink completion engine for lightning-fast code completion
- **File Navigation**: NeoTree file explorer with floating and sidebar modes
- **Fuzzy Finding**: Telescope for files, live grep, and symbol navigation
- **Relative Line Numbers**: Hybrid line numbers for efficient navigation
- **Professional Keybindings**: Carefully curated keyboard shortcuts for optimal workflow

## 📋 Requirements

- **Neovim**: v0.9.0 or later
- **Node.js**: For LSP and code completion
- **Python**: For Python language support and general tools
- **Git**: For plugin management with lazy.nvim
- **A Nerd Font**: For icons and visual elements (recommended: JetBrains Mono or Fantasque Sans Mono)

### Optional Dependencies

- **Docker**: For Docker plugin and container development
- **Language Servers**: Automatically installed for supported languages

## 🚀 Installation

### 1. Prerequisites

Ensure you have Neovim 0.9.0+ installed:

```bash
nvim --version
```

Install a Nerd Font. Popular choices:

- [JetBrains Mono Nerd Font](https://www.nerdfonts.com/)
- [Fantasque Sans Mono Nerd Font](https://www.nerdfonts.com/)

### 2. Clone the Configuration

Replace your existing Neovim config:

```bash
# Backup your current config if needed
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this configuration
git clone <your-repo-url> ~/.config/nvim
```

### 3. Launch Neovim

```bash
nvim
```

Lazy.nvim will automatically:

- Download and install all plugins
- Install language servers and tools
- Set up the development environment

The first startup may take 2-3 minutes as plugins are downloaded and compiled.

## 📁 Project Structure

```
.config/nvim/
├── init.lua                 # Main entry point with Neovide config
├── lazy-lock.json          # Plugin version lock file
├── lazyvim.json            # LazyVim configuration metadata
├── stylua.toml             # Lua code formatting configuration
│
└── lua/
    ├── config/             # Core configuration
    │   ├── autocmds.lua    # Autocommands and event handlers
    │   ├── keymaps.lua     # Custom keybindings
    │   ├── lazy.lua        # Plugin manager setup
    │   └── options.lua     # Editor settings and preferences
    │
    └── plugins/            # Plugin specifications and configs
        ├── colorschemes.lua    # Color theme configurations
        ├── docker.lua          # Docker integration
        ├── example.lua         # Example plugin setup
        ├── go.lua              # Go language support
        ├── java.lua            # Java language support
        ├── linux-tools.lua     # Linux development tools
        ├── neo-tree.lua        # File explorer configuration
        ├── python.lua          # Python language support
        ├── telescope.lua       # Fuzzy finder configuration
        ├── theme.lua           # UI theme customization
        ├── typescript.lua      # TypeScript/JavaScript support
        └── web.lua             # Web development tools
```

## ⌨️ Key Bindings

### General Navigation

| Binding      | Action                               |
| ------------ | ------------------------------------ |
| `<Space>`    | Leader key                           |
| `<Tab>`      | Next buffer                          |
| `<S-Tab>`    | Previous buffer                      |
| `<C-x>`      | Close current buffer                 |
| `<leader>X`  | Force close buffer (discard changes) |
| `<leader>bo` | Close other buffers                  |

### File Navigation

| Binding         | Action                          |
| --------------- | ------------------------------- |
| `<leader><Tab>` | Toggle NeoTree (sidebar left)   |
| `<leader>e`     | Toggle NeoTree (floating)       |
| `<leader>ff`    | Find files in current directory |
| `<leader>fp`    | Find plugin files               |

### Window Management

| Binding      | Action               |
| ------------ | -------------------- |
| `<leader>wx` | Close current window |

For more keybindings, see [keymaps.lua](lua/config/keymaps.lua) and the [LazyVim documentation](https://www.lazyvim.org/configuration/general#keymaps).

## 🎨 Customization

### Changing the Colorscheme

Edit [lua/plugins/colorschemes.lua](lua/plugins/colorschemes.lua):

```lua
-- Default colorscheme: Rosepine Moon
return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    lazy = false,
    config = function()
      require("rose-pine").setup({
        variant = "moon",
        styles = { transparency = true },
        disable_background = true,
        disable_float_background = true,
      })
      vim.cmd("colorscheme rose-pine-moon")
    end,
  },
}
```

Other available themes: Gruvbox (with dark hard and light soft variants) and Tokyodark.

### Modifying Editor Settings

Edit [lua/config/options.lua](lua/config/options.lua) to customize:

- Font and font size
- Tab width and indentation
- Line number display
- Scroll behavior
- Mouse and clipboard settings

### Adding Custom Keybindings

Add new keybindings to [lua/config/keymaps.lua](lua/config/keymaps.lua):

```lua
local map = vim.keymap.set
map("n", "<leader>custom", "<cmd>echo 'Custom binding'<cr>", { desc = "Custom action" })
```

### Enabling Neovide Features

Edit [init.lua](init.lua) to customize Neovide-specific settings:

- Cursor animation styles
- Opacity and transparency
- Scroll animations
- Window blur effects
- Refresh rate settings

## 🔧 Language Support

### Python

- LSP: Pyright
- Formatting: Black
- Linting: Ruff
- Configuration: [lua/plugins/python.lua](lua/plugins/python.lua)

### Go

- LSP: gopls
- Formatting: gofmt
- Testing tools integrated
- Configuration: [lua/plugins/go.lua](lua/plugins/go.lua)

### Java

- LSP: Eclipse JDT
- Build tools: Maven, Gradle support
- Configuration: [lua/plugins/java.lua](lua/plugins/java.lua)

### TypeScript/JavaScript

- LSP: TypeScript-language-server
- Formatting: Prettier
- Framework support: React, Vue, Angular
- Configuration: [lua/plugins/typescript.lua](lua/plugins/typescript.lua)

### Web Development

- HTML, CSS, SCSS support
- Emmet abbreviations
- Live reload capabilities
- Configuration: [lua/plugins/web.lua](lua/plugins/web.lua)

## 🐳 Docker Support

This config includes Docker integration for containerized development workflows:

```bash
# Docker commands and container management available within Neovim
# See lua/plugins/docker.lua for configuration details
```

## 🛠️ Linux Tools

Enhanced Linux development experience with integrated tools for system programming and scripting.

Configuration: [lua/plugins/linux-tools.lua](lua/plugins/linux-tools.lua)

## 📦 Plugin Management

This config uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management.

### Common Commands

```vim
:Lazy                    " Open lazy.nvim UI
:Lazy sync              " Sync all plugins
:Lazy update            " Update all plugins
:Lazy install           " Install missing plugins
:checkhealth            " Check plugin health
```

## 🎯 Performance

The configuration is optimized for performance with:

- Smart lazy-loading of plugins
- Disabled unnecessary rtp plugins
- Configurable checker for plugin updates
- Efficient plugin defaults

## 🤖 Copilot Chat

This configuration includes [copilot.lua](https://github.com/zbirenbaum/copilot.lua) and [copilot-chat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim) for AI-powered code assistance.

### Usage

- **Open Copilot Chat**: `<leader>ccq` (quick chat)
- **Toggle Chat Panel**: `<leader>cct`
- **Code Actions**: Copilot suggestions available in insert mode

See [lua/plugins/copilot.lua](lua/plugins/copilot.lua) for configuration.

## 🐛 Troubleshooting

### Plugins Not Loading

```vim
:Lazy sync
:checkhealth
```

### Missing LSPs or Formatters

LSPs are auto-installed for recognized file types. Manually trigger installation:

```vim
:Mason               " Open Mason UI
```

### Font Issues

Ensure you have installed a Nerd Font and configured it in your terminal or Neovide settings.

Update font in [lua/config/options.lua](lua/config/options.lua):

```lua
vim.o.guifont = "YourFont Nerd Font:h14"
```

### Slow Startup

Check loaded plugins:

```vim
:Lazy profile
```

## 📚 Learning Resources

- [Neovim Documentation](https://neovim.io/doc/)
- [LazyVim Documentation](https://www.lazyvim.org/)
- [Vim Tips & Tricks](https://vim.fandom.com/wiki/Vim_Tips_Wiki)
- [Lua Guide for Neovim](https://github.com/nanotee/nvim-lua-guide)

## 🤝 Contributing

Feel free to customize this configuration to match your workflow. Some ideas:

- Add language-specific plugins
- Create custom keybindings
- Integrate additional LSPs
- Add snippets and abbreviations
- Modify color schemes and themes

## 📄 License

This Neovim configuration is provided as-is. Refer to individual plugin licenses for details.

---

**Happy coding! 🎉**

For questions or issues, please check the [LazyVim documentation](https://www.lazyvim.org/) or the respective plugin repositories.
