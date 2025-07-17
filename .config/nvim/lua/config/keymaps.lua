-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- keymaps.lua for Lazy.nvim setup
local map = vim.keymap.set

-- Smart quit function
local function smart_quit()
  local buffers = vim.fn.getbufinfo({ buflisted = 1 })
  local visible_buffers = {}
  for _, buf in ipairs(buffers) do
    if buf.listed == 1 and vim.bo[buf.bufnr].buftype == "" then
      table.insert(visible_buffers, buf.bufnr)
    end
  end

  if #visible_buffers > 1 then
    vim.cmd("bdelete")
  else
    vim.cmd("quit")
  end
end

-- Buffer navigation
map("n", "<C-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<C-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

-- Alternative buffer navigation
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

-- Telescope
map("n", "<C-p>", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
map("n", "<C-f>", "<cmd>Telescope find_files<cr>", { desc = "Find files" })

-- Window splitting
map("n", "<leader>vs", "<cmd>vsplit<cr>", { desc = "Vertical split" })
map("n", "<leader>hs", "<cmd>split<cr>", { desc = "Horizontal split" })

-- Buffer management
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
map("n", "<leader>ba", "<cmd>%bdelete|edit#|bdelete#<cr>", { desc = "Delete all buffers except current" })
map("n", "<leader>q", smart_quit, { desc = "Smart quit" })

-- Create alternative quit commands
vim.api.nvim_create_user_command("Q", function()
  vim.cmd("quit!")
end, {})
vim.api.nvim_create_user_command("Sq", smart_quit, {})

-- Create a global function for the abbreviation
_G.smart_quit = smart_quit

-- Override :q using command-line abbreviation
vim.cmd('cnoreabbrev <expr> q (getcmdtype() == ":" && getcmdline() == "q") ? "lua smart_quit()" : "q"')
