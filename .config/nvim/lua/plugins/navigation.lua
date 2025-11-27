return {
  {
    "echasnovski/mini.bracketed",
    event = "VeryLazy",
    config = function()
      require("mini.bracketed").setup({
        -- Navigate buffers
        buffer = { suffix = "b", options = {} },
        -- Navigate comments
        comment = { suffix = "c", options = {} },
        -- Navigate conflicts
        conflict = { suffix = "x", options = {} },
        -- Navigate diagnostics
        diagnostic = { suffix = "d", options = {} },
        -- Navigate files
        file = { suffix = "f", options = {} },
        -- Navigate indentation
        indent = { suffix = "i", options = {} },
        -- Navigate jumps
        jump = { suffix = "j", options = {} },
        -- Navigate locations
        location = { suffix = "l", options = {} },
        -- Navigate oldfiles
        oldfile = { suffix = "o", options = {} },
        -- Navigate quickfix
        quickfix = { suffix = "q", options = {} },
        -- Navigate treesitter nodes
        treesitter = { suffix = "t", options = {} },
        -- Navigate undo
        undo = { suffix = "u", options = {} },
        -- Navigate windows
        window = { suffix = "w", options = {} },
        -- Navigate yank history
        yank = { suffix = "y", options = {} },
      })
    end,
  },
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    config = function()
      require("mini.ai").setup({
        -- Better text objects
        n_lines = 500,
        search_method = "cover_or_next",
      })
    end,
  },
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    config = function()
      require("mini.surround").setup({
        mappings = {
          add = "sa", -- Add surrounding in Normal and Visual modes
          delete = "sd", -- Delete surrounding
          find = "sf", -- Find surrounding (to the right)
          find_left = "sF", -- Find surrounding (to the left)
          highlight = "sh", -- Highlight surrounding
          replace = "sr", -- Replace surrounding
          update_n_lines = "sn", -- Update `n_lines`
        },
      })
    end,
  },
}
