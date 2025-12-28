return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
    },
    config = function()
      -- Setup treesitter
      require('nvim-treesitter').setup({
        install_dir = vim.fn.stdpath('data') .. '/site',
      })
      
      -- Install parsers
      local parsers = {
        "bash", "c", "cpp", "css", "dockerfile", "go", "gomod",
        "html", "java", "javascript", "json", "jsonc", "lua",
        "markdown", "markdown_inline", "python", "query", "regex",
        "tsx", "typescript", "vim", "yaml",
      }
      
      require('nvim-treesitter').install(parsers)
      
      -- Enable treesitter highlighting for all filetypes
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          pcall(vim.treesitter.start)
        end,
        desc = "Enable treesitter highlighting",
      })
      
      -- Enable folding
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo[0][0].foldmethod = 'expr'
          vim.wo[0][0].foldenable = false
        end,
        desc = "Enable treesitter folding",
      })
      
      -- Setup treesitter-context
      local ok_context, ts_context = pcall(require, "treesitter-context")
      if ok_context then
        ts_context.setup({
          enable = true,
          max_lines = 0,
          min_window_height = 0,
          line_numbers = true,
          multiline_threshold = 20,
          trim_scope = "outer",
          mode = "cursor",
          separator = nil,
          zindex = 20,
        })
      end
      
      -- Link treesitter highlights to vim groups for better colorscheme compatibility
      local function link_ts_highlights()
        local links = {
          ["@variable"] = "Identifier",
          ["@variable.builtin"] = "Special",
          ["@variable.parameter"] = "Identifier",
          ["@variable.member"] = "Identifier",
          ["@constant"] = "Constant",
          ["@constant.builtin"] = "Special",
          ["@module"] = "Include",
          ["@label"] = "Label",
          ["@string"] = "String",
          ["@character"] = "Character",
          ["@number"] = "Number",
          ["@boolean"] = "Boolean",
          ["@float"] = "Float",
          ["@function"] = "Function",
          ["@function.builtin"] = "Special",
          ["@function.call"] = "Function",
          ["@function.method"] = "Function",
          ["@constructor"] = "Special",
          ["@keyword"] = "Keyword",
          ["@keyword.function"] = "Keyword",
          ["@keyword.return"] = "Keyword",
          ["@keyword.operator"] = "Keyword",
          ["@keyword.conditional"] = "Conditional",
          ["@keyword.repeat"] = "Repeat",
          ["@keyword.import"] = "Include",
          ["@operator"] = "Operator",
          ["@type"] = "Type",
          ["@type.builtin"] = "Type",
          ["@property"] = "Identifier",
          ["@attribute"] = "PreProc",
          ["@comment"] = "Comment",
          ["@comment.documentation"] = "SpecialComment",
          ["@comment.todo"] = "Todo",
          ["@punctuation.delimiter"] = "Delimiter",
          ["@punctuation.bracket"] = "Delimiter",
          ["@punctuation.special"] = "Special",
          ["@tag"] = "Tag",
          ["@tag.attribute"] = "Identifier",
          ["@tag.delimiter"] = "Delimiter",
        }
        
        for capture, group in pairs(links) do
          vim.api.nvim_set_hl(0, capture, { link = group, default = false })
        end
      end
      
      -- Apply highlight links
      link_ts_highlights()
      
      -- Reapply on colorscheme change
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.schedule(function()
            link_ts_highlights()
          end)
        end,
        desc = "Relink treesitter highlights",
      })
    end,
  },
}
