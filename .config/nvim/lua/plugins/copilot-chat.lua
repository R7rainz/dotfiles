return {
  -- GitHub Copilot completion (already installed)
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<Tab>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      panel = {
        enabled = true,
        auto_refresh = false,
        keymap = {
          jump_prev = "[[",
          jump_next = "]]",
          accept = "<CR>",
          refresh = "gr",
          open = "<M-CR>",
        },
        layout = {
          position = "bottom",
          ratio = 0.4,
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
      copilot_node_command = "node",
      server_opts_overrides = {},
    },
  },

  -- Copilot Chat integration
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      debug = false,
      
      -- Chat window configuration
      window = {
        layout = "vertical", -- 'vertical', 'horizontal', 'float'
        width = 0.4, -- fractional width of parent
        height = 0.6, -- fractional height of parent
        border = "rounded", -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
        title = "Copilot Chat",
      },
      
      -- Selection configuration
      selection = function(source)
        local select = require("CopilotChat.select")
        return select.visual(source) or select.buffer(source)
      end,
      
      -- Model and temperature
      model = "gpt-4",
      temperature = 0.1,
      
      -- Prompts
      prompts = {
        Explain = {
          prompt = "/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.",
        },
        Review = {
          prompt = "/COPILOT_REVIEW Review the selected code.",
        },
        Fix = {
          prompt = "/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.",
        },
        Optimize = {
          prompt = "/COPILOT_GENERATE Optimize the selected code to improve performance and readability.",
        },
        Docs = {
          prompt = "/COPILOT_GENERATE Please add documentation comment for the selection.",
        },
        Tests = {
          prompt = "/COPILOT_GENERATE Please generate tests for my code.",
        },
        FixDiagnostic = {
          prompt = "Please assist with the following diagnostic issue in file:",
          selection = function(source)
            return require("CopilotChat.select").diagnostics(source)
          end,
        },
        Commit = {
          prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
          selection = function(source)
            return require("CopilotChat.select").gitdiff(source)
          end,
        },
        CommitStaged = {
          prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
          selection = function(source)
            return require("CopilotChat.select").gitdiff(source, true)
          end,
        },
      },
    },
    config = function(_, opts)
      local chat = require("CopilotChat")
      local select = require("CopilotChat.select")
      
      chat.setup(opts)
      
      -- Custom prompts
      vim.api.nvim_create_user_command("CopilotChatVisual", function(args)
        chat.ask(args.args, { selection = select.visual })
      end, { nargs = "*", range = true })
      
      -- Inline chat command
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
      
      -- Buffer chat command
      vim.api.nvim_create_user_command("CopilotChatBuffer", function(args)
        chat.ask(args.args, { selection = select.buffer })
      end, { nargs = "*" })
    end,
    keys = {
      -- Toggle chat window
      {
        "<leader>aa",
        function()
          local chat = require("CopilotChat")
          chat.toggle()
        end,
        desc = "Toggle Copilot Chat",
        mode = { "n", "v" },
      },
      
      -- Open chat with visual selection
      {
        "<leader>av",
        ":CopilotChatVisual ",
        desc = "Copilot Chat (Visual)",
        mode = "x",
      },
      
      -- Quick chat
      {
        "<leader>aq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "Quick Chat",
        mode = { "n", "v" },
      },
      
      -- Prompts
      {
        "<leader>ae",
        "<cmd>CopilotChatExplain<cr>",
        desc = "Explain Code",
        mode = { "n", "v" },
      },
      {
        "<leader>ar",
        "<cmd>CopilotChatReview<cr>",
        desc = "Review Code",
        mode = { "n", "v" },
      },
      {
        "<leader>af",
        "<cmd>CopilotChatFix<cr>",
        desc = "Fix Code",
        mode = { "n", "v" },
      },
      {
        "<leader>ao",
        "<cmd>CopilotChatOptimize<cr>",
        desc = "Optimize Code",
        mode = { "n", "v" },
      },
      {
        "<leader>ad",
        "<cmd>CopilotChatDocs<cr>",
        desc = "Generate Docs",
        mode = { "n", "v" },
      },
      {
        "<leader>at",
        "<cmd>CopilotChatTests<cr>",
        desc = "Generate Tests",
        mode = { "n", "v" },
      },
      {
        "<leader>aD",
        "<cmd>CopilotChatFixDiagnostic<cr>",
        desc = "Fix Diagnostic",
        mode = { "n", "v" },
      },
      {
        "<leader>ac",
        "<cmd>CopilotChatCommit<cr>",
        desc = "Generate Commit Message",
        mode = "n",
      },
      {
        "<leader>as",
        "<cmd>CopilotChatCommitStaged<cr>",
        desc = "Generate Commit (Staged)",
        mode = "n",
      },
    },
  },
}
