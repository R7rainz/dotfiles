-- Enhanced snippets for web development
return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "honza/vim-snippets",
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_snipmate").lazy_load()

      -- Custom React/Next.js snippets
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      ls.add_snippets("typescriptreact", {
        s("rfc", {
          t("import React from 'react'"),
          t({ "", "", "interface " }),
          i(1, "Props"),
          t(" {"),
          t({ "", "  " }),
          i(2, "// props"),
          t({ "", "}" }),
          t({ "", "", "const " }),
          i(3, "Component"),
          t(": React.FC<"),
          i(4, "Props"),
          t("> = ("),
          i(5, "props"),
          t(") => {"),
          t({ "", "  return (" }),
          t({ "", "    <div>" }),
          t({ "", "      " }),
          i(0),
          t({ "", "    </div>" }),
          t({ "", "  )" }),
          t({ "", "}" }),
          t({ "", "", "export default " }),
          i(6, "Component"),
        }),
      })
    end,
  },
}
