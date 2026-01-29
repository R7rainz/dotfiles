return {
  {
    "andweeb/presence.nvim",
    event = "VeryLazy",
    opts = {
      auto_update = true,

      -- 🔹 App visuals
      neovim_image_text = "Neovim",
      main_image = "file", -- IMPORTANT (see section 2)
      client_id = "793271441293967371",

      debounce_timeout = 10,
      enable_line_number = false,
      show_time = true,
      buttons = true,

      -- 🔹 Rich Presence text
      editing_text = "Editing %s",
      reading_text = "Reading %s",
      file_explorer_text = "Browsing %s",
      plugin_manager_text = "Managing plugins",

      -- Shows repo/workspace name
      workspace_text = "Working on %s",

      -- 🔹 GitHub buttons (MAX 2)
      buttons = {
        {
          label = "GitHub Profile",
          url = "https://github.com/r7rainz",
        },
      },
    },

    config = function(_, opts)
      require("presence").setup(opts)

      vim.keymap.set("n", "<leader>dc", function()
        vim.cmd("PresenceCancel")
        vim.defer_fn(function()
          vim.cmd("Presence")
        end, 500)
        vim.notify("Discord Presence toggled", vim.log.levels.INFO)
      end, { desc = "Toggle Discord Presence", silent = true })

      vim.keymap.set("n", "<leader>dd", "<cmd>PresenceCancel<cr>", {
        desc = "Disable Discord Presence",
        silent = true,
      })

      vim.keymap.set("n", "<leader>de", "<cmd>Presence<cr>", {
        desc = "Enable Discord Presence",
        silent = true,
      })
    end,
  },
}
