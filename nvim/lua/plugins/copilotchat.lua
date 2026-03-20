return {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
        { "github/copilot.vim" }, 
        { "nvim-lua/plenary.nvim" }, 
    },
    build = "make tiktoken",
    opts = {
        mappings = {
        -- Submit with Ctrl+s in Insert Mode
            submit_prompt = {
                normal = "<CR>",
                insert = "<C-s>",
            },
            close = {
                normal = "q",
                insert = "<C-c>",
            },
        },
        window = {
            
            layout = "horizontal", -- 'vertical' | 'horizontal'
            position = "bottom", -- 'left', 'right', 'top', 'bottom'
            width = 80, -- Fixed width in columns
            height = 20, -- Fixed height in rows
            border = 'rounded', -- 'single', 'double', 'rounded', 'solid'
            title = '🤖 AI Assistant',
            zindex = 100, -- Ensure window stays on top}
             
        },
        headers = {
            assistant = '🤖 Copilot',
            user = '👤 You',
            tool = '🔧 Tool',
        },
        separator = '━━',
        auto_fold = true, -- Automatically folds non-assistant messages
    },
  config = function(_, opts)
    local chat = require("CopilotChat")
    
    -- Initialize the chat
    chat.setup(opts)

    -- Toggle Command
    vim.api.nvim_create_user_command("CopilotChatToggle", function(args)
      chat.toggle()
    end, { nargs = "*" })
  end,
  
  -- Keys to open the chat
  keys = {
    { "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
    { "<leader>ce", "<cmd>CopilotChatExplain<cr>", mode = "v", desc = "Explain Code" },
    { "<leader>cf", "<cmd>CopilotChatFix<cr>", mode = "v", desc = "Fix Code" },
  },
}
