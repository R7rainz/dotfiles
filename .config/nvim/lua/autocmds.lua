require "nvchad.autocmds"

-- Disable indent-blankline after it loads
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		pcall(function()
			require("ibl").setup({ enabled = false })
		end)
	end,
})
