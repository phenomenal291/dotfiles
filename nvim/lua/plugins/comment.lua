return {
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup({
      -- This adds the standard mappings:
      -- `gcc` - Toggles the current line using linewise comment
      -- `gbc` - Toggles the current line using blockwise comment
      -- `gc`  - Toggles the region using linewise comment (Visual mode)
      -- `gb`  - Toggles the region using blockwise comment (Visual mode)
    })
  end
}
