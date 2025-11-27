require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Smart buffer close function
local function close_buffer()
  local bufnr = vim.api.nvim_get_current_buf()
  local bufcount = #vim.fn.getbufinfo({ buflisted = 1 })
  
  -- If this is the last buffer, open a new empty buffer first
  if bufcount <= 1 then
    vim.cmd("enew")
  else
    vim.cmd("bprevious")
  end
  
  -- Delete the original buffer
  pcall(vim.api.nvim_buf_delete, bufnr, { force = false })
end

-- Force close buffer
local function force_close_buffer()
  local bufnr = vim.api.nvim_get_current_buf()
  local bufcount = #vim.fn.getbufinfo({ buflisted = 1 })
  
  if bufcount <= 1 then
    vim.cmd("enew")
  else
    vim.cmd("bprevious")
  end
  
  pcall(vim.api.nvim_buf_delete, bufnr, { force = true })
end

-- Close all buffers except current
local function close_other_buffers()
  local current = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()
  
  for _, buf in ipairs(buffers) do
    if buf ~= current and vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
      pcall(vim.api.nvim_buf_delete, buf, { force = false })
    end
  end
  
  vim.notify("Closed all other buffers", vim.log.levels.INFO)
end

-- Better buffer management
map("n", "<leader>x", close_buffer, { desc = "Close current buffer" })
map("n", "<leader>X", force_close_buffer, { desc = "Force close current buffer" })
map("n", "<C-q>", close_buffer, { desc = "Close buffer" })

-- Navigate buffers
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Close all buffers except current
map("n", "<leader>bo", close_other_buffers, { desc = "Close other buffers" })

-- Close all buffers
map("n", "<leader>bD", "<cmd>bufdo bdelete<CR>", { desc = "Close all buffers" })

-- Better terminal management with persistent state
local term_state = {
  horizontal_id = nil,
  vertical_id = nil,
  float_id = nil,
}

-- Toggle horizontal terminal
local function toggle_horizontal_term()
  require("nvchad.term").toggle({ pos = "sp", id = "htoggleTerm", size = 0.3 })
end

-- Toggle vertical terminal
local function toggle_vertical_term()
  require("nvchad.term").toggle({ pos = "vsp", id = "vtoggleTerm", size = 0.4 })
end

-- Toggle floating terminal
local function toggle_floating_term()
  require("nvchad.term").toggle({ pos = "float", id = "floatTerm" })
end

-- Terminal toggle (like VS Code Ctrl+`) - always horizontal
map({ "n", "t" }, "<C-`>", toggle_horizontal_term, { desc = "Toggle terminal" })

-- Alternative terminal toggle (in case backtick doesn't work)
map({ "n", "t" }, "<C-\\>", toggle_horizontal_term, { desc = "Toggle terminal (alt)" })

-- Horizontal terminal
map("n", "<leader>tt", toggle_horizontal_term, { desc = "Toggle horizontal terminal" })

-- Theme picker
map("n", "<leader>th", "<cmd>Telescope themes<CR>", { desc = "Change theme" })

-- Vertical terminal
map("n", "<leader>tv", toggle_vertical_term, { desc = "Toggle vertical terminal" })

-- Floating terminal
map({ "n", "t" }, "<A-i>", toggle_floating_term, { desc = "Toggle floating terminal" })
map("n", "<leader>tf", toggle_floating_term, { desc = "Toggle floating terminal (alt)" })

-- Easy escape from terminal mode
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Escape terminal mode" })
map("t", "jk", "<C-\\><C-n>", { desc = "Escape terminal mode" })

-- Navigate between windows easily
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Resize window splits
map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- ========================================
-- ENHANCED NAVIGATION & EDITING
-- ========================================

-- Better page navigation (center cursor after jump)
map("n", "<C-f>", "<C-d>zz", { desc = "Page down (centered)" })
map("n", "<C-b>", "<C-u>zz", { desc = "Page up (centered)" })
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- Jump to matching bracket/brace and center
map("n", "%", "%zz", { desc = "Jump to matching bracket (centered)" })

-- Jump into empty brackets/functions
map("n", "<leader>jb", "/[\\[{(]\\s*[\\]})]<CR>:noh<CR>va{<Esc>i<CR><Esc>O", { desc = "Jump into empty brackets" })
map("n", "<leader>jf", "/function.*{\\s*}<CR>:noh<CR>va{<Esc>i<CR><Esc>O", { desc = "Jump into empty function" })

-- Quick jump to next/prev empty line
map("n", "}", "}zz", { desc = "Next paragraph (centered)" })
map("n", "{", "{zz", { desc = "Previous paragraph (centered)" })

-- Move selected lines up/down (like VS Code Alt+Up/Down)
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting (stay in visual mode)
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Join lines but keep cursor position
map("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })

-- Paste without overwriting register in visual mode
map("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Delete without yanking
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

-- Quick search and replace word under cursor
map("n", "<leader>rw", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Replace word under cursor" })

-- Select all
map("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Increment/decrement numbers
map("n", "+", "<C-a>", { desc = "Increment number" })
map("n", "-", "<C-x>", { desc = "Decrement number" })

-- Better undo break points (break undo sequence at punctuation)
map("i", ",", ",<C-g>u", { desc = "Undo break point" })
map("i", ".", ".<C-g>u", { desc = "Undo break point" })
map("i", "!", "!<C-g>u", { desc = "Undo break point" })
map("i", "?", "?<C-g>u", { desc = "Undo break point" })

-- Quick save
map("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
map("i", "<C-s>", "<Esc><cmd>w<CR>a", { desc = "Save file (insert mode)" })

-- Navigate to next/previous function/class (using treesitter via mini.bracketed)
-- These will work after you install the navigation.lua plugin
-- [t / ]t = prev/next treesitter node
-- [c / ]c = prev/next comment
-- [d / ]d = prev/next diagnostic
