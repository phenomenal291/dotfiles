return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("mason-nvim-dap").setup({
      ensure_installed = { "codelldb", "python" },
      
      handlers = {
        function(config)
          require('mason-nvim-dap').default_setup(config)
        end,
        
        -- C++ CONFIGURATION
        codelldb = function(config)
          config.configurations = {
            {
              name = "Launch file",
              type = "codelldb",
              request = "launch",
              program = function()
                return vim.fn.getcwd() .. '/' .. vim.fn.expand('%:r')
              end,
              cwd = '${workspaceFolder}',
              stopOnEntry = false,
            },
          }
          require('mason-nvim-dap').default_setup(config)
        end,

        -- PYTHON CONFIGURATION
        python = function(config)
          config.adapters = {
            type = "executable",
            command = "/usr/bin/python3",
            args = { "-m", "debugpy.adapter" },
          }
          config.configurations = {
            {
              type = "python",
              request = "launch",
              name = "Launch file",
              program = "${file}",
              pythonPath = function()
                 -- Check if a venv is already active in the terminal
                local venv = os.getenv("VIRTUAL_ENV")
                if venv then
                  return venv .. "/bin/python"
                end

                -- Check for a folder named "venv" or ".venv" in the project
                local cwd = vim.fn.getcwd()
                if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                  return cwd .. "/venv/bin/python"
                elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                  return cwd .. "/.venv/bin/python"
                end

                -- Fallback to system python
                return "/usr/bin/python3"
              end,
            },
          }
          require('mason-nvim-dap').default_setup(config)          require('mason-nvim-dap').default_setup(config)
        end,
      },
    })

    dapui.setup()

    -- Auto-open UI
    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end

    -- Keybindings
    vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, {}) -- Toggle Breakpoint
    vim.keymap.set("n", "<Leader>dc", dap.continue, {})          -- Start/Continue
    vim.keymap.set("n", "<Leader>dx", function() dapui.close() end, {}) -- Close UI
    vim.keymap.set("n", "<Leader>du", dap.clear_breakpoints, {}) -- Clear all breakpoints
  end,
}
