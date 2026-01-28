return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {},
  config = function()
    require("ibl").setup({
      indent = { char = "│" }, -- The character to use for the line
      scope = { enabled = true }, -- Highlights the current code block
    })
  end,
}
