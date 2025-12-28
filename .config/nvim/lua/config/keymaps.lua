-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Helpers
local function close_other_buffers()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted and buf ~= current then
      vim.cmd("bdelete " .. buf)
    end
  end
end

-- Neo-tree keybindings
-- <leader><tab> = LEFT sidebar tree (always left)
-- <leader>e    = Floating tree (always floating)
map("n", "<leader><tab>", "<cmd>Neotree toggle left reveal=true<cr>", { desc = "Toggle NeoTree (left)" })
map("n", "<leader>e", "<cmd>Neotree float reveal=true<cr>", { desc = "NeoTree (floating)" })

-- Buffer navigation with Tab
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

-- Telescope file finding (force override after LazyVim/snacks)
vim.schedule(function()
  map("n", "<leader>ff", function()
    require("telescope.builtin").find_files({ cwd = vim.loop.cwd() })
  end, { desc = "Find Files" })

  map("n", "<leader>fp", function()
    require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
  end, { desc = "Find Plugin File" })
end)

-- Close current buffer without quitting Neovim
map("n", "<C-x>", "<cmd>bdelete<cr>", { desc = "Close buffer" })

-- Force close current buffer (discard changes)
map("n", "<leader>X", "<cmd>bdelete!<cr>", { desc = "Force close buffer" })

-- Close other buffers, keep current
map("n", "<leader>bo", close_other_buffers, { desc = "Close other buffers" })

-- Close current window
map("n", "<leader>wx", "<cmd>close<cr>", { desc = "Close window" })

-- Close current tab
map("n", "<leader>tx", "<cmd>tabclose<cr>", { desc = "Close tab" })

-- Quit commands
map("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>qQ", "<cmd>q!<cr>", { desc = "Quit (force)" })
map("n", "<leader>qa", "<cmd>qa<cr>", { desc = "Quit all" })
map("n", "<leader>qA", "<cmd>qa!<cr>", { desc = "Quit all (force)" })

-- Close lists
map("n", "<leader>cx", "<cmd>cclose<cr>", { desc = "Close quickfix" })
map("n", "<leader>lx", "<cmd>lclose<cr>", { desc = "Close location list" })

-- Find files in entire system (start from home directory)
map("n", "<leader>fA", function()
  require("telescope.builtin").find_files({ cwd = vim.loop.os_homedir() })
end, { desc = "Find files (all folders)" })
