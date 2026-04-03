-- Reset custom highlights on colorscheme change
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("CustomHighlights", { clear = true }),
  callback = function()
    -- Example: Only set custom highlights for specific colorschemes
    if vim.g.colors_name == "nightfox" or vim.g.colors_name == "carbonfox" then
      local groups = {
        Normal = { bg = "#000000" },
        NormalNC = { bg = "#000000" },
        NormalFloat = { bg = "#000000" },
        SignColumn = { bg = "#000000" },
        FoldColumn = { bg = "#000000" },
        LineNr = { bg = "#000000" },
        CursorLineNr = { bg = "#000000" },
        CursorLine = { bg = "#050505" },
        NeoTreeNormal = { bg = "#000000" },
        NeoTreeNormalNC = { bg = "#000000" },
        TelescopeNormal = { bg = "#000000" },
        TelescopeBorder = { bg = "#000000" },
      }
      for group, opts in pairs(groups) do
        vim.api.nvim_set_hl(0, group, opts)
      end
    end
    -- Add more colorscheme-specific highlight logic here if needed
  end,
})
-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.o.termguicolors = true

-- Set relative line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Set tab and indentation settings
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.breakindent = true

-- Enable clipboard integration
vim.o.clipboard = "unnamedplus"

-- Set a comfortable scroll offset - keeps cursor centered vertically
vim.o.scrolloff = 15
vim.o.sidescrolloff = 8

-- Removed global highlight overrides for CursorLine and CursorLineNr to prevent background issues when switching colorschemes
-- Disable LSP semantic tokens entirely to stop them overriding treesitter/colorscheme
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

-- Hard-disable semantic token handlers
vim.lsp.handlers["textDocument/semanticTokens/full"] = function() end
vim.lsp.handlers["textDocument/semanticTokens/full/delta"] = function() end
vim.lsp.handlers["textDocument/semanticTokens/range"] = function() end

-- Enable inlay hints (guarded for older Neovim versions)
if vim.lsp.inlay_hint and vim.lsp.inlay_hint.enable then
  vim.lsp.inlay_hint.enable(true)
end

-- LSP diagnostics: enable virtual text, signs, and underlines with VS Code–style squiggles
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 2,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Strong undercurl diagnostics so errors/warnings are clearly visible
local diag_colors = {
  error = "#f7768e",
  warn = "#e0af68",
  info = "#7aa2f7",
  hint = "#9ece6a",
}

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = diag_colors.error })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = diag_colors.warn })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = diag_colors.info })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = diag_colors.hint })

-- Disable list characters (no indent markers, tabs, spaces, etc.)
vim.opt.list = false

-- Disable netrw (vim's default file explorer) since we use neo-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

