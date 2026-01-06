return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 20,
      open_mapping = [[<C-\>]], 
      direction = "float",
      float_opts = {
        border = "curved",
        width = 130,
        height = 30,
      },
    })
    
    -- LazyGit Shortcut (Optional)
    local Terminal  = require('toggleterm.terminal').Terminal
    local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

    function _lazygit_toggle()
      lazygit:toggle()
    end

    vim.keymap.set("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>", {desc = "Toggle LazyGit"})
  end
}
