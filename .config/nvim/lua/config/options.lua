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

-- Enable inlay hints
vim.lsp.inlay_hint.enable(true)

-- Disable list characters (no indent markers, tabs, spaces, etc.)
vim.opt.list = false

-- Disable netrw (vim's default file explorer) since we use neo-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1