return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300 -- Wait 300ms before showing the popup
  end,
  opts = {
    -- You can customize specific labels here
    spec = {
      { "<leader>d", group = "Debug" },
      { "<leader>s", group = "Split Window" },
      { "<leader>g", group = "Git" },
    },
  },
}
