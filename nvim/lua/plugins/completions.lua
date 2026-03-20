return {
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
  { "rafamadriz/friendly-snippets" },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "copilot-chat"},
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
      })

        -- Add this AFTER your main cmp.setup() call
        local cmp = require("cmp")

        cmp.setup.filetype("copilot-chat", {
          sources = {
            { name = "copilot-chat" }, -- Only this source is needed in chat
            -- { name = "path" },      -- Optional: if you want to autocomplete file paths
          },
        })
    end,
    
  },
    {
      "L3MON4D3/LuaSnip",
      build = "make install_jsregexp", 
      dependencies = { "saadparwaiz1/cmp_luasnip", "rafamadriz/friendly-snippets" },
    },
}
