return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        theme = "material", -- Matches your theme
        component_separators = '',
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = {
          { 'mode', separator = { left = '' }, right_padding = 2 },
        },
        lualine_b = { 'filename', 'branch' },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
          { 'filetype', separator = { right = '' }, left_padding = 2 },
        },
      },
    })
  end,
}
