-- Test configuration validity
print("=== Testing NeoVim Configuration ===\n")

local function test_plugin(name)
  local ok, plugin = pcall(require, name)
  if ok then
    print("✓ " .. name .. " loaded successfully")
    return true
  else
    print("✗ " .. name .. " failed: " .. tostring(plugin))
    return false
  end
end

local function test_lspconfig()
  local ok, lspconfig = pcall(require, "lspconfig")
  if not ok then
    print("✗ lspconfig failed to load")
    return false
  end
  
  local servers = {
    "eslint", "emmet_ls", "clangd", "html", "cssls", 
    "tailwindcss", "jsonls", "lua_ls", "pyright", "bashls"
  }
  
  print("\n=== LSP Server Configurations ===")
  for _, server in ipairs(servers) do
    if lspconfig[server] then
      print("✓ " .. server .. " configured")
    else
      print("✗ " .. server .. " NOT configured")
    end
  end
  return true
end

-- Test core plugins
print("\n=== Core Plugins ===")
test_plugin("nvim-treesitter")
test_plugin("cmp")
test_plugin("luasnip")
test_plugin("telescope")
test_plugin("mason")

-- Test formatters/linters
print("\n=== Formatters/Linters ===")
test_plugin("null-ls")
test_plugin("conform")

-- Test completion
print("\n=== Completion Sources ===")
test_plugin("cmp_nvim_lsp")
test_plugin("cmp_luasnip")
test_plugin("cmp_buffer")
test_plugin("cmp_path")

-- Test LSP
test_lspconfig()

print("\n=== Configuration Test Complete ===")
