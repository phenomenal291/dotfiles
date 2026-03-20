return {
  "github/copilot.vim",
  cmd = "Copilot",
  event = "InsertEnter", -- Load when you start typing
  config = function()
    -- Disable Tab mapping so it doesn't conflict with other plugins
    -- We will use <C-j> for accepting suggestions instead
    vim.g.copilot_no_tab_map = true
    
    -- Set your custom accept key (Ctrl+j is standard/safe)
    vim.keymap.set('i', '<C-j>', 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false
    })
  end,
}
