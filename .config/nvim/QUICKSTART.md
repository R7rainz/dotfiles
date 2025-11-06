# Quick Start Guide - Neovim Configuration

## ✅ Configuration is Ready!

Your Neovim is now configured with VSCode/Zed-like completions and smooth workflow.

## First Time Setup

1. **Install LSP Servers and Tools** (one-time setup):
   ```bash
   nvim
   ```
   Then inside Neovim:
   ```
   :MasonInstallAll
   ```
   Wait for all installations to complete.

2. **Verify Installation**:
   ```
   :checkhealth
   :Mason
   :Lazy
   ```

## Daily Usage

### Completion Features

When typing, completions appear automatically! Here's what you get:

- **Intelligent code completion** from LSP servers
- **Function signatures** showing parameter types
- **Ghost text** preview (subtle gray text showing suggestion)
- **Snippets** for common code patterns
- **Path completion** for file paths
- **Buffer words** from current file

### Key Shortcuts for Completion

| Key | Action |
|-----|--------|
| `<C-Space>` | Manually trigger completion |
| `<Tab>` | Next item / Expand snippet |
| `<S-Tab>` | Previous item / Previous snippet field |
| `<CR>` (Enter) | Confirm selection |
| `<C-e>` | Close completion menu |
| `<C-b>` / `<C-f>` | Scroll documentation up/down |
| `<Alt-e>` | Fast wrap selection in brackets |

### LSP Features (Work like VSCode)

| Key | Action | Command |
|-----|--------|---------|
| `gd` | Go to definition | `:lua vim.lsp.buf.definition()` |
| `gr` | Find references | `:lua vim.lsp.buf.references()` |
| `K` | Show hover info | `:lua vim.lsp.buf.hover()` |
| `<leader>ca` | Code actions | `:lua vim.lsp.buf.code_action()` |
| `<leader>rn` | Rename symbol | `:lua vim.lsp.buf.rename()` |
| `[d` / `]d` | Previous/Next diagnostic | |

## Supported Languages

Your config now supports:

### Web Development
- HTML, CSS, SCSS
- JavaScript, TypeScript, JSX/TSX
- JSON, YAML, TOML
- Tailwind CSS
- Emmet

### Systems Programming
- C, C++
- Rust
- Go
- Python

### Shell & DevOps
- Bash
- Docker
- YAML

### Configuration
- Lua (with Neovim API support)

## GitHub Copilot

Copilot is enabled! Use:
- `<leader>cc` - Copilot commands
- See `:CopilotChat` for AI assistance

## Troubleshooting

### Completion not showing?
1. Make sure you're in Insert mode
2. Press `<C-Space>` to trigger manually
3. Check if LSP is running: `:LspInfo`

### LSP not working for a file type?
1. Open the file
2. Run `:LspInfo` to see attached servers
3. Install missing server: `:Mason`

### Formatting not working?
1. Check if formatter is installed: `:Mason`
2. Format manually: `:lua vim.lsp.buf.format()`

### Plugins not loading?
1. Run `:Lazy sync`
2. Restart Neovim
3. Check `:Lazy` for any errors

## Tips for Best Experience

1. **Use Treesitter** - Better syntax highlighting (already enabled)
2. **Format on save** - Uncomment in `lua/configs/conform.lua`
3. **Auto-complete as you type** - Already enabled with nvim-cmp
4. **Use virtual text** for diagnostics - Shows errors inline
5. **Inlay hints** - Already enabled for TypeScript/Rust

## Performance

Your config is optimized with:
- Lazy loading of plugins
- Debounced completions (60ms)
- Disabled unused vim plugins
- Fast startup time

## Getting Help

- `:help nvim-cmp` - Completion help
- `:help lsp` - LSP help
- `:help telescope` - Fuzzy finder help
- `:checkhealth` - Diagnose issues

---

**Enjoy your supercharged Neovim! 🚀**

For detailed changes, see `FIXES_APPLIED.md`
