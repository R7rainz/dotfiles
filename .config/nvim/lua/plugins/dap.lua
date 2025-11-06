return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      local present, dap = pcall(require, "dap")
      if not present then
        return
      end
      local dapui = require("dapui")
      dapui.setup()
      -- Keep default adapter setup; add instructions in README to install codelldb or use mason
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
  },
}
