return {
  "marko-cerovac/material.nvim",
  lazy = false,    -- Make sure it loads immediately on startup
  priority = 1000, -- Force it to load before other plugins
  config = function()
    require("material").setup({
      contrast = {
        terminal = false,             -- Don't override terminal colors
        sidebars = true,              -- Slightly darker sidebars (Neo-tree)
        floating_windows = true,      -- Darker floating windows (CopilotChat, CMP)
        cursor_line = true,           -- Highlight the line you are on
        non_current_windows = true,   -- Dim inactive split windows
      },
      
      disable_background = true,
      
      -- Make comments italicized (helps differentiate them from code)
      italics = {
        comments = true,
        keywords = true,
        functions = false,
        strings = false,
        variables = false,
      },
    })

    -- Available options: 'darker', 'lighter', 'oceanic', 'palenight', 'deep ocean'
    vim.g.material_style = "darker"

    -- Apply the colorscheme
    vim.cmd("colorscheme material")
  end,
}
