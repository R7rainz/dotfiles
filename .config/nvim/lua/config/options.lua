-- Options configuration
local opt = vim.opt

-- General
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.completeopt = "menuone,noinsert,noselect"

-- UI
opt.number = true
opt.relativenumber = true
opt.showmode = false
opt.signcolumn = "yes"
opt.colorcolumn = "80"
opt.cursorline = true
opt.termguicolors = true
opt.laststatus = 3
opt.cmdheight = 1
opt.pumheight = 10
opt.winminwidth = 5
opt.splitbelow = true
opt.splitright = true

-- Editing
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

-- Performance
opt.updatetime = 250
opt.timeoutlen = 300
opt.undofile = true
opt.backup = false
opt.writebackup = false

-- Folding
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

vim.lsp.set_log_level("error")
