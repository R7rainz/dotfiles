return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "canary",
  dependencies = {
    { "github/copilot.vim" }, -- or github/copilot.vim
    { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    { "nvim-telescope/telescope.nvim" }, -- Use telescope for help actions
  },
  opts = {
    debug = true, -- Enable debugging
    show_help = true, -- Show help actions
    window = {
      layout = "float",
    },
    auto_follow_cursor = false, -- Don't follow the cursor after getting response
  },
  config = function(_, opts)
    local chat = require("CopilotChat")
    local select = require("CopilotChat.select")
    -- Use unnamed register for the selection
    opts.selection = select.unnamed

    -- Override the git prompts message
    opts.prompts = opts.prompts or {}
    opts.prompts.Commit = {
      prompt = "Write commit message for the change with commitizen convention",
      selection = select.gitdiff,
    }
    opts.prompts.CommitStaged = {
      prompt = "Write commit message for the change with commitizen convention",
      selection = function(source)
        return select.gitdiff(source, true)
      end,
    }

    chat.setup(opts)

    vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
      chat.ask(args.args, { selection = select.visual })
    end, { nargs = "*", range = true })

    -- Inline chat with Copilot
    vim.api.nvim_create_user_command("CopilotChatInline", function(args)
      chat.ask(args.args, {
        selection = select.visual,
        window = {
          layout = "float",
          relative = "cursor",
          width = 1,
          height = 0.4,
          row = 1,
        },
      })
    end, { nargs = "*", range = true })

    -- Inline chat with current buffer context
    vim.api.nvim_create_user_command("CopilotChatInlineBuffer", function(args)
      chat.ask(args.args, {
        selection = select.buffer,
        window = {
          layout = "float",
          relative = "cursor",
          width = 1,
          height = 0.4,
          row = 1,
        },
      })
    end, { nargs = "*" })

    -- Restore CopilotChatBuffer
    vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
      chat.ask(args.args, { selection = select.buffer })
    end, { nargs = "*", range = true })
  end,
  event = "VeryLazy",
  keys = {
    -- Show help actions with telescope
    {
      "<leader>cch",
      function()
        local actions = require("CopilotChat.actions")
        require("CopilotChat.integrations.telescope").pick(actions.help_actions())
      end,
      desc = "CopilotChat - Help actions",
    },
    -- Show prompts actions with telescope
    {
      "<leader>ccp",
      function()
        local actions = require("CopilotChat.actions")
        require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
      end,
      desc = "CopilotChat - Prompt actions",
    },
    -- Code related commands
    { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "CopilotChat - Explain code" },
    { "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "CopilotChat - Generate tests" },
    { "<leader>ccr", "<cmd>CopilotChatReview<cr>", desc = "CopilotChat - Review code" },
    { "<leader>ccR", "<cmd>CopilotChatRefactor<cr>", desc = "CopilotChat - Refactor code" },
    { "<leader>ccn", "<cmd>CopilotChatBetterNamings<cr>", desc = "CopilotChat - Better Naming" },

    -- { "<leader>ci", ":CopilotChatInline ", mode = "x", desc = "CopilotChat - Inline chat with selection" },
    -- { "<leader>cm", "<cmd>CopilotChatCommit<cr>", desc = "CopilotChat - Generate commit message" },
    -- { "<leader>cq", "<cmd>CopilotChatBuffer<cr>", desc = "CopilotChat - Quick chat" },
    -- Chat with Copilot in visual mode
    {
      "<leader>ccv",
      ":CopilotChatVisual",
      mode = "x",
      desc = "CopilotChat - Open in vertical split",
    },
    {
      "<leader>i",
      function()
        local input = vim.fn.input("Inline Chat: ")
        if input ~= "" then
          vim.cmd("CopilotChatInline " .. input)
        end
      end,
      mode = "n",
      desc = "CopilotChat - Inline chat",
    },
    -- Also add a visual mode binding for inline chat
    {
      "<leader>ccx",
      ":CopilotChatInline ",
      mode = "x",
      desc = "CopilotChat - Inline chat with selection",
    },
    {
      "<leader>cci",
      function()
        local input = vim.fn.input("Ask Copilot: ")
        if input ~= "" then
          vim.cmd("CopilotChat " .. input)
        end
      end,
      desc = "CopilotChat - Ask input",
    },
    -- Generate commit message based on the git diff
    {
      "<leader>ccm",
      "<cmd>CopilotChatCommit<cr>",
      desc = "CopilotChat - Generate commit message for all changes",
    },
    {
      "<leader>ccM",
      "<cmd>CopilotChatCommitStaged<cr>",
      desc = "CopilotChat - Generate commit message for staged changes",
    },
    -- Quick chat with Copilot
    {
      "<leader>ccq",
      function()
        local input = vim.fn.input("Quick Chat: ")
        if input ~= "" then
          vim.cmd("CopilotChatBuffer " .. input)
        end
      end,
      desc = "CopilotChat - Quick chat",
    },
    -- Debug
    { "<leader>ccd", "<cmd>CopilotChatDebugInfo<cr>", desc = "CopilotChat - Debug Info" },
    -- Fix the issue with diagnostic
    { "<leader>ccf", "<cmd>CopilotChatFixDiagnostic<cr>", desc = "CopilotChat - Fix Diagnostic" },
    -- Clear buffer and chat history
    { "<leader>ccl", "<cmd>CopilotChatReset<cr>", desc = "CopilotChat - Clear buffer and chat history" },
    -- Toggle Copilot Chat Vsplit
    { "<leader>ccv", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle Vsplit" },
  },
}
