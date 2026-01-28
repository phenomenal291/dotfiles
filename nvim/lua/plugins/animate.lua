return {
  "echasnovski/mini.animate",
  version = "*",
  event = "VeryLazy",
  config = function()
    -- Load the plugin
    local animate = require("mini.animate")
    
    animate.setup({
      -- 1. Cursor Movement Animation
      cursor = {
        enable = true, 
        timing = animate.gen_timing.cubic({ duration = 200, unit = "total" }), -- 200ms cursor move
      },

      -- 2. Scrolling Animation
      scroll = {
        enable = true,
        timing = animate.gen_timing.cubic({ duration = 400, unit = "total" }), -- 400ms scroll
      },

      -- 3. Window Resize Animation
      resize = {
        enable = true,
        timing = animate.gen_timing.cubic({ duration = 250, unit = "total" }),
      },

      -- 4. Window Open/Close Animation
      open = {
        enable = true,
        timing = animate.gen_timing.cubic({ duration = 250, unit = "total" }),
      },
      
      close = {
        enable = true,
        timing = animate.gen_timing.cubic({ duration = 250, unit = "total" }),
      },
    })
  end,
}
