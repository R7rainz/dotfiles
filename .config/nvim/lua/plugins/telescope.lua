return {
  -- Telescope, using LazyVim's default styling
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        cond = function()
          return vim.fn.executable("cmake") == 1
        end,
      },
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files({})
        end,
        desc = "Find Files",
      },
      {
        "<leader>fD",
        function()
          local function pick_dirs(opts)
            opts = opts or {}
            local cmd
            if vim.fn.executable("fd") == 1 then
              cmd = { "fd", "--type", "d", "--strip-cwd-prefix" }
            elseif vim.fn.executable("fdfind") == 1 then
              cmd = { "fdfind", "--type", "d" }
            elseif vim.fn.executable("find") == 1 then
              cmd = { "find", ".", "-type", "d" }
            else
              vim.notify("No supported directory finder found (fd/fdfind/find)", vim.log.levels.ERROR)
              return
            end
            require("telescope.builtin").find_files({
              prompt_title = "Find Folders",
              cwd = opts.cwd,
              previewer = false,
              find_command = cmd,
              attach_mappings = function(prompt_bufnr, map)
                local actions = require("telescope.actions")
                local state = require("telescope.actions.state")
                local function open_dir()
                  local entry = state.get_selected_entry()
                  if not entry then
                    return
                  end
                  local dir = entry.path or entry[1] or entry.value
                  actions.close(prompt_bufnr)
                  if dir and #dir > 0 then
                    vim.cmd("cd " .. vim.fn.fnameescape(dir))
                    require("telescope.builtin").find_files({ cwd = dir })
                  end
                end
                map("i", "<CR>", open_dir)
                map("n", "<CR>", open_dir)
                return true
              end,
            })
          end
          pick_dirs({})
        end,
        desc = "Find Folders",
      },
      {
        "<leader>fd",
        function()
          local documents_root = vim.fn.expand("~/Documents")
          local cmd
          if vim.fn.executable("fd") == 1 then
            cmd = { "fd", "--type", "d", "--max-depth", "3", "--strip-cwd-prefix" }
          elseif vim.fn.executable("fdfind") == 1 then
            cmd = { "fdfind", "--type", "d" }
          elseif vim.fn.executable("find") == 1 then
            cmd = { "find", ".", "-type", "d", "-maxdepth", "3" }
          else
            vim.notify("No supported directory finder found (fd/fdfind/find)", vim.log.levels.ERROR)
            return
          end
          require("telescope.builtin").find_files({
            prompt_title = "Find Folders: Documents",
            cwd = documents_root,
            previewer = false,
            find_command = cmd,
            attach_mappings = function(prompt_bufnr, map)
              local actions = require("telescope.actions")
              local state = require("telescope.actions.state")
              local function open_dir()
                local entry = state.get_selected_entry()
                if not entry then
                  return
                end
                local dir = entry.path or entry[1] or entry.value
                actions.close(prompt_bufnr)
                if dir and #dir > 0 then
                  vim.cmd("cd " .. vim.fn.fnameescape(dir))
                  require("telescope.builtin").find_files({ cwd = dir })
                end
              end
              map("i", "<CR>", open_dir)
              map("n", "<CR>", open_dir)
              return true
            end,
          })
        end,
        desc = "Find Folders in Documents",
      },
      {
        "<leader>fw",
        function()
          require("telescope.builtin").live_grep({
            styles = { "ivy" },
          })
        end,
        desc = "Find Words (Live Grep)",
      },
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
    },
    opts = {
      defaults = {
        prompt_prefix = "  ",
        selection_caret = "  ",
        entry_prefix = "  ",
        path_display = { "truncate" },
        layout_strategy = "flex",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.55 },
          vertical = { mirror = false },
          width = 0.9,
          height = 0.8,
          preview_cutoff = 120,
        },
        sorting_strategy = "ascending",
        winblend = 10,
        borderchars = {
          prompt = { "━", "┃", "━", "┃", "┏", "┓", "┛", "┗" },
          results = { "━", "┃", "━", "┃", "┏", "┓", "┛", "┗" },
          preview = { "━", "┃", "━", "┃", "┏", "┓", "┛", "┗" },
        },
      },
      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
      },
    },
  },

-- Better icons (used by telescope, neo-tree, etc.)
  {
    "nvim-tree/nvim-web-devicons",
    opts = {
      override = {
        zsh = {
          icon = "",
          color = "#428850",
          cterm_color = "65",
          name = "Zsh",
        },
        fish = {
          icon = "",
          color = "#4d5a5e",
          name = "Fish",
        },
        bash = {
          icon = "",
          color = "#89e051",
          name = "Bash",
        },
        sh = {
          icon = "",
          color = "#4d5a5e",
          name = "Shell",
        },
      },
      color_icons = true,
      default = true,
      strict = true,
      override_by_filename = {
        [".gitignore"] = {
          icon = "",
          color = "#f1502f",
          name = "Gitignore",
        },
        [".gitattributes"] = {
          icon = "",
          color = "#f1502f",
          name = "GitAttributes",
        },
        ["docker-compose.yml"] = {
          icon = "󰡨",
          color = "#0db7ed",
          name = "DockerCompose",
        },
        ["Dockerfile"] = {
          icon = "󰡨",
          color = "#0db7ed",
          name = "Dockerfile",
        },
        [".dockerignore"] = {
          icon = "󰡨",
          color = "#0db7ed",
          name = "DockerIgnore",
        },
        ["package.json"] = {
          icon = "",
          color = "#e8274b",
          name = "PackageJson",
        },
        ["package-lock.json"] = {
          icon = "",
          color = "#7a0d21",
          name = "PackageLockJson",
        },
        ["README.md"] = {
          icon = "",
          color = "#519aba",
          name = "Readme",
        },
        ["LICENSE"] = {
          icon = "",
          color = "#cbcb41",
          name = "License",
        },
        [".env"] = {
          icon = "",
          color = "#faf743",
          name = "Env",
        },
        ["go.mod"] = {
          icon = "",
          color = "#519aba",
          name = "GoMod",
        },
        ["go.sum"] = {
          icon = "",
          color = "#519aba",
          name = "GoSum",
        },
      },
      override_by_extension = {
        ["log"] = {
          icon = "󰌱",
          color = "#81e043",
          name = "Log",
        },
        ["py"] = {
          icon = "",
          color = "#4B8BBE",
          name = "Python",
        },
        ["js"] = {
          icon = "",
          color = "#cbcb41",
          name = "JavaScript",
        },
        ["ts"] = {
          icon = "",
          color = "#519aba",
          name = "TypeScript",
        },
        ["jsx"] = {
          icon = "",
          color = "#20c2e3",
          name = "JavaScriptReact",
        },
        ["tsx"] = {
          icon = "",
          color = "#519aba",
          name = "TypeScriptReact",
        },
        ["go"] = {
          icon = "",
          color = "#519aba",
          name = "Go",
        },
        ["rs"] = {
          icon = "",
          color = "#dea584",
          name = "Rust",
        },
        ["java"] = {
          icon = "",
          color = "#cc3e44",
          name = "Java",
        },
        ["md"] = {
          icon = "",
          color = "#519aba",
          name = "Markdown",
        },
        ["yaml"] = {
          icon = "",
          color = "#6d8086",
          name = "Yaml",
        },
        ["yml"] = {
          icon = "",
          color = "#6d8086",
          name = "Yml",
        },
        ["json"] = {
          icon = "",
          color = "#cbcb41",
          name = "Json",
        },
        ["toml"] = {
          icon = "",
          color = "#6d8086",
          name = "Toml",
        },
        ["lua"] = {
          icon = "",
          color = "#51a0cf",
          name = "Lua",
        },
        ["vim"] = {
          icon = "",
          color = "#019833",
          name = "Vim",
        },
      },
    },
  },
}
