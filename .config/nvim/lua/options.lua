require "nvchad.options"

-- Enhanced UI options
local o = vim.o

-- Enable cursorline for better visibility
o.cursorlineopt = 'both'

-- Better line numbers
o.relativenumber = true
o.numberwidth = 4

-- Better scrolling
o.scrolloff = 8
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
