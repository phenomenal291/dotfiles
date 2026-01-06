return {
    "nvim-treesitter/nvim-treesitter",
    tag = "v0.9.2", -- PINNED: The last version that works perfectly on 0.10
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "python" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end,
}
