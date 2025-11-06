return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {
			ui = {
				check_outdated_packages_on_open = true,
				border = "rounded",
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					-- TypeScript/JavaScript ecosystem
					"eslint",
					"html",
					"cssls",
					"tailwindcss",
					"emmet_ls",
					-- C/C++
					"clangd",
					-- Python
					"pyright",
					-- System/DevOps
					"bashls",
					"dockerls",
					"yamlls",
					-- Other languages
					"lua_ls",
					"jsonls",
					"rust_analyzer",
					"gopls",
				},
				automatic_installation = true,
			})
			
			-- Ensure LSP config is loaded after mason-lspconfig
			vim.schedule(function()
				require("configs.lspconfig")
			end)
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- Formatters
					"prettier",
					"prettierd",
					"clang-format",
					"stylua",
					"black",
					"isort",
					"shfmt",
					-- Linters
					"eslint_d",
					"cpplint",
					"shellcheck",
					"pylint",
					-- DAP (Debug Adapters)
					"codelldb",
					"js-debug-adapter",
				},
				auto_update = true,
				run_on_start = true,
			})
		end,
	},
}
