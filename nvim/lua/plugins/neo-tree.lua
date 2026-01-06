return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      window = { width = 30 },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = { enabled = true },
      },
    })

    vim.keymap.set("n", "<Tab>", function()
      -- If the cursor is currently inside Neo-tree, close it
      if vim.bo.filetype == "neo-tree" then
        vim.cmd("Neotree close")
      else
        -- Otherwise, focus it (which opens it if it was closed)
        vim.cmd("Neotree focus filesystem left")
      end
    end, {})
  end,
}
