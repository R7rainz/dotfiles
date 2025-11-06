return {
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
		config = function()
			local status_ok, tstools = pcall(require, "typescript-tools")
			if not status_ok then
				return
			end

			tstools.setup({
				on_attach = function(client, bufnr)
					-- Disable formatting in favor of null-ls/prettier
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end,
				settings = {
					separate_diagnostic_server = true,
					publish_diagnostic_on = "insert_leave",
					expose_as_code_action = {},
					tsserver_path = nil,
					tsserver_plugins = {},
					tsserver_max_memory = "auto",
					tsserver_format_options = {},
					tsserver_file_preferences = {
						includeInlayParameterNameHints = "all",
						includeInlayParameterNameHintsWhenArgumentMatchesName = false,
						includeInlayFunctionParameterTypeHints = true,
						includeInlayVariableTypeHints = true,
						includeInlayVariableTypeHintsWhenTypeMatchesName = false,
						includeInlayPropertyDeclarationTypeHints = true,
						includeInlayFunctionLikeReturnTypeHints = true,
						includeInlayEnumMemberValueHints = true,
					},
					tsserver_locale = "en",
					complete_function_calls = true,
					include_completions_with_insert_text = true,
					code_lens = "off",
					disable_member_code_lens = true,
					jsx_close_tag = {
						enable = true,
						filetypes = { "javascriptreact", "typescriptreact" },
					},
				},
			})
		end,
	},
}
