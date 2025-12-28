return {
  -- Make LazyVim use the last used colorscheme (persisted),
  -- falling back to rosepine the first time.
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      local theme_state = vim.fn.stdpath("data") .. "/last_colorscheme.txt"
      local cs = "rose-pine" -- fallback if nothing saved yet
      if vim.fn.filereadable(theme_state) == 1 then
        local lines = vim.fn.readfile(theme_state)
        if lines[1] and lines[1] ~= "" then
          cs = lines[1]
        end
      end
      opts.colorscheme = cs
    end,
  },
}
