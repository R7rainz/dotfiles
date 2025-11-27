require "nvchad.options"

-- Enhanced UI options
local o = vim.o

-- Enable cursorline for better visibility
o.cursorlineopt = 'both'

-- Better line numbers
o.relativenumber = true
o.numberwidth = 4

-- Better scrolling (cursor stays away from edges)
o.scrolloff = 12  -- Keep cursor 12 lines from top/bottom
o.sidescrolloff = 8

-- Better splits
o.splitbelow = true
o.splitright = true

-- Better search
o.ignorecase = true
o.smartcase = true

-- Better completion
o.pumheight = 15
o.pumblend = 10

-- Better wrapping
o.wrap = false
o.linebreak = true

-- Mouse support
o.mouse = "a"

-- Clipboard
o.clipboard = "unnamedplus"

-- Undo and backup
o.undofile = true
o.swapfile = false
o.backup = false

-- Update time (faster completion)
o.updatetime = 250
o.timeoutlen = 300

-- Better colors
o.termguicolors = true

-- Sign column always visible
o.signcolumn = "yes"

-- Disable indent-blankline
vim.g.indent_blankline_enabled = false
vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankline_show_trailing_blankline_indent = false
