return {
      {
        "williamboman/mason.nvim",
        config = function()
          require("mason").setup()
        end,
      },
      { "williamboman/mason-lspconfig.nvim",
        version = "v1.31.0", 
        opts = {
          ensure_installed = { "lua_ls", "clangd", "pyright" },
          auto_install = true,
        },
      },
      {
        "neovim/nvim-lspconfig",
        config = function()
          local lspconfig = require("lspconfig")
          local capabilities = require('cmp_nvim_lsp').default_capabilities()

          require("mason-lspconfig").setup_handlers({
            function(server_name)
              lspconfig[server_name].setup({
                capabilities = capabilities,
              })
            end,
          })

          vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
        end,
      },
    vim.diagnostic.config({
      -- 1. Virtual Text (The text next to the code)
      virtual_text = {
        -- Only show text for ERROR and WARN. Hide HINT and INFO.
        severity = { min = vim.diagnostic.severity.WARN }, 
        spacing = 4,
        prefix = '●', -- Uses a dot instead of "E", "H", etc. for a cleaner look
      },
      
      -- 2. Signs (The icons in the left gutter column)
      signs = {
        -- Keep showing signs for everything (including Hints) 
        -- so you know the issue exists, but it won't clutter your code.
        severity = { min = vim.diagnostic.severity.HINT },
      },

      -- 3. General settings
      underline = true,
      update_in_insert = false, -- Don't flicker messages while you are typing
      severity_sort = true,
    })
}
