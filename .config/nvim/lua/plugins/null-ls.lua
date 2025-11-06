return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local status_ok, null_ls = pcall(require, "null-ls")
			if not status_ok then
				vim.notify("null-ls failed to load", vim.log.levels.WARN)
				return
			end

			local formatting = null_ls.builtins.formatting
			local diagnostics = null_ls.builtins.diagnostics

			local sources = {}

			-- Safe source addition with pcall
			local function safe_add(source_func, config)
				local ok, source = pcall(function()
					if config then
						return source_func.with(config)
					else
						return source_func
					end
				end)
				if ok and source then
					table.insert(sources, source)
				end
			end

			-- Prettier/Prettierd for formatting
			if vim.fn.executable("prettierd") == 1 then
				safe_add(formatting.prettierd, {
					prefer_local = "node_modules/.bin",
					extra_filetypes = { "svelte", "vue" },
				})
			elseif vim.fn.executable("prettier") == 1 then
				safe_add(formatting.prettier, {
					prefer_local = "node_modules/.bin",
					extra_filetypes = { "svelte", "vue" },
				})
			end

			-- C/C++ formatting
			if vim.fn.executable("clang-format") == 1 then
				safe_add(formatting.clang_format, {
					extra_args = { "--style=file" },
				})
			end

			-- Lua formatting
			if vim.fn.executable("stylua") == 1 then
				safe_add(formatting.stylua)
			end

			-- Python formatting
			if vim.fn.executable("black") == 1 then
				safe_add(formatting.black)
			end
			if vim.fn.executable("isort") == 1 then
				safe_add(formatting.isort)
			end

			-- Shell formatting
			if vim.fn.executable("shfmt") == 1 then
				safe_add(formatting.shfmt, {
					extra_args = { "-i", "2", "-bn", "-ci", "-sr" },
				})
			end

			-- Shell diagnostics
			if vim.fn.executable("shellcheck") == 1 then
				safe_add(diagnostics.shellcheck)
			end

			-- Setup null-ls (wrap in pcall for extra safety)
			local setup_ok = pcall(function()
				null_ls.setup({
					debug = false,
					sources = sources,
					on_attach = function(client, bufnr)
						if client.supports_method("textDocument/formatting") then
							vim.api.nvim_create_autocmd("BufWritePre", {
								buffer = bufnr,
								callback = function()
									pcall(function()
										vim.lsp.buf.format({
											bufnr = bufnr,
											filter = function(c)
												return c.name == "null-ls"
											end,
											timeout_ms = 2000,
										})
									end)
								end,
							})
						end
					end,
				})
			end)

			if not setup_ok then
				vim.notify("null-ls setup failed", vim.log.levels.WARN)
			end
		end,
	},
}
