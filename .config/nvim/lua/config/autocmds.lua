-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Disable auto-commenting on new line
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "r", "o" })
  end,
  desc = "Disable auto-comment on new line",
})

-- When a session restores buffers, skip the start screen and jump to a real file.
-- If no real file buffers exist (e.g. previous session had none), open Telescope in this project.
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.defer_fn(function()
      local bufs = vim.fn.getbufinfo({ buflisted = 1 })
      local found = false
      -- Find the first "normal" file buffer and jump to it
      for _, buf in ipairs(bufs) do
        if buf.name ~= "" and buf.listed then
          pcall(vim.api.nvim_set_current_buf, buf.bufnr)
          found = true
          break
        end
      end
      -- If no real file buffer is available and we're on an empty buffer,
      -- open Telescope file picker in the current project directory
      if not found then
        local cur = vim.api.nvim_get_current_buf()
        local name = vim.api.nvim_buf_get_name(cur)
        if name == "" or vim.fn.line2byte("$") == -1 then
          pcall(function()
            require("telescope.builtin").find_files({ cwd = vim.loop.cwd() })
          end)
        end
      end
    end, 150)
  end,
  desc = "Jump from start screen or open Telescope in empty session",
})

-- Remember last used colorscheme and restore it on next start
local theme_state = vim.fn.stdpath("data") .. "/last_colorscheme.txt"

-- Save colorscheme whenever it changes (e.g. via <leader>uC)
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function(ev)
    pcall(vim.fn.writefile, { ev.match }, theme_state)
    -- Ensure termguicolors is always on for proper color display
    vim.opt.termguicolors = true
    -- Force treesitter highlight refresh after colorscheme loads
    vim.defer_fn(function()
      if vim.fn.exists(":TSEnable") > 0 then
        vim.cmd("TSEnable highlight")
      end
    end, 100)
  end,
  desc = "Persist last colorscheme and refresh treesitter",
})

-- On dashboard/landing buffers, map `p` to global project search (home dir)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "alpha", "starter", "lazy" },
  callback = function(ctx)
    local bufnr = ctx.buf
    -- Defer so dashboard's own keymaps are set first, then we override `p`
    vim.schedule(function()
      vim.keymap.set("n", "p", function()
        pcall(function()
          require("telescope.builtin").find_files({ cwd = vim.loop.os_homedir() })
        end)
      end, { buffer = bufnr, desc = "Project search (all folders)" })
    end)
  end,
  desc = "On landing page: `p` opens project search over all folders",
})

-- Go-specific indentation settings (Go uses tabs, not spaces)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "gomod", "gowork", "gosum" },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
  desc = "Go indentation settings (tabs)",
})

-- Python indentation settings (4 spaces per PEP 8)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
  desc = "Python indentation settings (4 spaces)",
})

-- JavaScript/TypeScript indentation settings (2 spaces is common)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
  desc = "JS/TS indentation settings (2 spaces)",
})

-- HTML/CSS indentation settings (2 spaces)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "css", "scss", "sass", "less" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
  desc = "HTML/CSS indentation settings (2 spaces)",
})

-- Java indentation settings (4 spaces)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "java" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
  desc = "Java indentation settings (4 spaces)",
})

-- Shell/Bash indentation settings (2 spaces)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sh", "bash", "zsh", "fish" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
  desc = "Shell indentation settings (2 spaces)",
})

-- YAML/Docker/Config files (2 spaces)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "yaml", "yml", "dockerfile", "toml", "json", "jsonc" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
  desc = "Config files indentation settings (2 spaces)",
})

-- Makefile indentation (tabs required)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "make", "cmake" },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 0
  end,
  desc = "Makefile indentation settings (tabs)",
})

vim.api.nvim_create_autocmd("ColorSchemePre", {
  callback = function()
    vim.cmd("hi clear")
    vim.o.background = "dark"
  end,
  desc = "Reset highlights and set dark background before colorscheme change",
})
