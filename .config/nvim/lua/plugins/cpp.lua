return {
    -- C/C++ LSP using LazyVim's LSP framework (no custom config override)
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                clangd = {
                    cmd = {
                        "clangd",
                        "--background-index",
                        "--clang-tidy",
                        "--completion-style=detailed",
                        "--header-insertion=iwyu",
                    },
                    filetypes = { "c", "cpp", "objc", "objcpp" },
                },
            },
        },
    },

    -- Ensure clangd is installed via mason-lspconfig
    {
        "mason-org/mason-lspconfig.nvim",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            if not vim.tbl_contains(opts.ensure_installed, "clangd") then
                table.insert(opts.ensure_installed, "clangd")
            end
        end,
    },


}
