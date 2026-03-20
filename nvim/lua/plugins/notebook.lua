return {
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    build = ":UpdateRemotePlugins",
    dependencies = { "3rd/image.nvim" },
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      
      -- Performance settings
      vim.g.molten_auto_open_output = false
      vim.g.molten_enter_output_behavior = "open_and_enter"
      vim.g.molten_output_win_max_height = 20
      vim.g.molten_wrap_output = true
      
      -- UI settings
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
    end, -- <--- This 'end' was missing or misplaced in your code
    
    -- Keys must be OUTSIDE the init function
    keys = {
        { "<leader>mi", ":MoltenInit<CR>", desc = "[m]olten [i]nit" },
        { "<leader>e", ":MoltenEvaluateOperator<CR>", desc = "evaluate operator", silent = true, mode = "n" },
        { "<leader>r", ":<C-u>MoltenEvaluateVisual<CR>gv", desc = "execute visual selection", silent = true, mode = "v" },
        { "<leader>os", ":noautocmd MoltenEnterOutput<CR>", desc = "open output window", silent = true },
        { "<leader>oh", ":MoltenHideOutput<CR>", desc = "close output window", silent = true },
        { "<leader>md", ":MoltenDelete<CR>", desc = "delete Molten cell", silent = true },
        { "<leader>rc", ":MoltenReevaluateCell<CR>", desc = "Run whole cell" },

        -- Navigation & Cell Creation (Converted to Lazy.nvim format)
        { "<leader>nc", "o# %%<CR><Esc>", desc = "New Cell below" },
        { "]c", "/^# %%<CR>", desc = "Next Cell" },
        { "[c", "?^# %%<CR>", desc = "Previous Cell" },
    },
  },
  {
    "GCBallesteros/jupytext.nvim",
    opts = {
        style = "percent", 
        output_extension = "py",
        force_ft = "python",
        cmd = os.getenv("HOME") .. '/miniconda3/bin/jupytext', 
    },
  },
}
