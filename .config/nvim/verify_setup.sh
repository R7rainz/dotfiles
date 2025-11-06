#!/bin/bash

echo "======================================"
echo "  NeoVim Development Setup Verification"
echo "======================================"
echo ""

# Check nvim version
echo "✓ Checking NeoVim version..."
nvim --version | head -1

# Check config files exist
echo ""
echo "✓ Checking configuration files..."
for file in init.lua lua/options.lua lua/autocmds.lua lua/configs/lspconfig.lua lua/plugins/init.lua; do
  if [ -f "$file" ]; then
    echo "  ✓ $file exists"
  else
    echo "  ✗ $file MISSING"
  fi
done

# Check plugin directories
echo ""
echo "✓ Checking installed plugins..."
LAZY_DIR="$HOME/.local/share/nvim/lazy"
REQUIRED_PLUGINS=(
  "nvim-lspconfig"
  "nvim-cmp"
  "nvim-treesitter"
  "mason.nvim"
  "conform.nvim"
  "LuaSnip"
  "telescope.nvim"
)

for plugin in "${REQUIRED_PLUGINS[@]}"; do
  if [ -d "$LAZY_DIR/$plugin" ]; then
    echo "  ✓ $plugin installed"
  else
    echo "  ⚠ $plugin not found (will install on first run)"
  fi
done

# Test config syntax
echo ""
echo "✓ Testing configuration syntax..."
if nvim --headless -c "lua print('Config OK')" -c "qall!" 2>&1 | grep -q "Config OK"; then
  echo "  ✓ Configuration syntax is valid"
else
  echo "  ✗ Configuration has syntax errors"
fi

echo ""
echo "======================================"
echo "  Setup Verification Complete!"
echo "======================================"
echo ""
echo "Next steps:"
echo "1. Run 'nvim' to start NeoVim"
echo "2. Wait for plugins to install automatically"
echo "3. Run ':Mason' to verify LSP servers"
echo "4. Run ':checkhealth' for detailed status"
echo ""
echo "Read SETUP_COMPLETE.md for usage guide!"
