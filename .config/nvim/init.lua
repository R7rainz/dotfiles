vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

vim.opt.termguicolors = true
vim.opt.nu = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.scrolloff = 8
vim.opt.clipboard:append("unnamedplus")

-- Hightlight yanking
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    callback = function()
        vim.hl.on_yank()
    end,
})

if vim.fn.executable "xsel" == 1 then
  vim.g.clipboard = {
    name = "xsel",
    copy = { ["+"] = "xsel --input --clipboard", ["*"] = "xsel --input --primary" },
    paste = { ["+"] = "xsel --output --clipboard", ["*"] = "xsel --output --primary" },
    cache_enabled = 0,
  }
end
vim.opt.relativenumber = true

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = {
  defaults = { lazy = true },
  install = { colorscheme = { "nvchad" } },
  ui = {
    icons = {
      ft = "",
      lazy = "󰂠 ",
      loaded = "",
      not_loaded = "",
    },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "2html_plugin", "tohtml", "getscript", "getscriptPlugin", "gzip",
        "logipat", "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers",
        "matchit", "tar", "tarPlugin", "rrhelper", "spellfile_plugin",
        "vimball", "vimballPlugin", "zip", "zipPlugin", "tutor", "rplugin",
        "syntax", "synmenu", "optwin", "compiler", "bugreport", "ftplugin",
      },
    },
  },
}

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

local function clear_backgrounds()
  vim.api.nvim_set_hl(0, "Normal", { bg = nil })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = nil })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = nil })
  vim.api.nvim_set_hl(0, "LineNr", { bg = nil })
  vim.api.nvim_set_hl(0, "CursorLineNr", { bg = nil })
  vim.api.nvim_set_hl(0, "FoldColumn", { bg = nil })
end

clear_backgrounds()

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = clear_backgrounds,
})

require "autocmds"
require "nvchad.mappings"

local map = vim.keymap.set

local function close_other_buffers()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted and buf ~= current then
      vim.cmd("bdelete " .. buf)
    end
  end
end

map("n", "<leader><tab>", "<cmd>NvimTreeToggle<cr>", { desc = "File Explorer (sidebar)" })
map("n", "<leader>e", function()
  require("telescope.builtin").find_files { prompt_title = "Files" }
end, { desc = "Find Files (float)" })

map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<C-x>", "<cmd>bdelete<cr>", { desc = "Close buffer" })
map("n", "<leader>X", "<cmd>bdelete!<cr>", { desc = "Force close buffer" })
map("n", "<leader>bo", close_other_buffers, { desc = "Close other buffers" })

map("n", "<leader>ff", function()
  require("telescope.builtin").find_files { cwd = vim.loop.cwd() }
end, { desc = "Find Files" })
map("n", "<leader>fp", function()
  require("telescope.builtin").find_files { cwd = require("lazy.core.config").options.root }
end, { desc = "Find Plugin File" })
map("n", "<leader>fA", function()
  require("telescope.builtin").find_files { cwd = vim.loop.os_homedir() }
end, { desc = "Find files (home)" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })
map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files" })

map("n", "<C-h>", "<C-w>h", { desc = "Focus left pane" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus bottom pane" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus top pane" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus right pane" })

map("n", "<leader>wx", "<cmd>close<cr>", { desc = "Close window" })

map("n", "<leader>tx", "<cmd>tabclose<cr>", { desc = "Close tab" })

map("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>qQ", "<cmd>q!<cr>", { desc = "Quit (force)" })
map("n", "<leader>qa", "<cmd>qa<cr>", { desc = "Quit all" })
map("n", "<leader>qA", "<cmd>qa!<cr>", { desc = "Quit all (force)" })

map("n", "<leader>cx", "<cmd>cclose<cr>", { desc = "Close quickfix" })
map("n", "<leader>lx", "<cmd>lclose<cr>", { desc = "Close location list" })

map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })
map("n", "gr", vim.lsp.buf.references, { desc = "References" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
map("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type Definition" })
map("n", "<leader>fs", vim.lsp.buf.document_symbol, { desc = "Document Symbols" })
map("n", "<leader>ws", vim.lsp.buf.workspace_symbol, { desc = "Workspace Symbols" })

map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
map("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostics to Loclist" })

map("n", "<leader>cf", function()
  require("conform").format { bufnr = 0, lsp_fallback = true }
end, { desc = "Format" })

map("n", "<leader>tt", function()
  local Terminal = require("toggleterm.terminal").Terminal
  if not _horizontal_term then
    _horizontal_term = Terminal:new { direction = "horizontal", hidden = true }
  end
  _horizontal_term:toggle()
end, { desc = "Terminal (horizontal)" })
map("n", "<leader>tv", function()
  local Terminal = require("toggleterm.terminal").Terminal
  if not _vertical_term then
    _vertical_term = Terminal:new { direction = "vertical", hidden = true }
  end
  _vertical_term:toggle()
end, { desc = "Terminal (vertical)" })
map("n", "<C-`>", function()
  local Terminal = require("toggleterm.terminal").Terminal
  if not _float_term then
    _float_term = Terminal:new { direction = "float", hidden = true }
  end
  _float_term:toggle()
end, { desc = "Terminal (float)" })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>w/", "<C-w>v", { desc = "Split vertical" })
map("n", "<leader>w-", "<C-w>s", { desc = "Split horizontal" })
map("n", "<leader>ww", "<C-w>w", { desc = "Next window" })
