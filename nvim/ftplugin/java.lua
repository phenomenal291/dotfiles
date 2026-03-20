local jdtls = require('jdtls')
local jdtls_setup = require('jdtls.setup')

-- 1. Construct the path to the workspace folder
--    This ensures every project has its own data folder (like IntelliJ .idea)
local home = os.getenv('HOME')
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = home .. '/.cache/jdtls-workspace/' .. project_name

-- 2. Find the path to the Mason installation
--    This dynamically finds where Mason installed the Java Server
local mason_path = vim.fn.stdpath("data") .. "/mason"
local launcher_jar = vim.fn.glob(mason_path .. "/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")
local config_path = mason_path .. "/packages/jdtls/config_linux" -- Change to config_mac or config_win if needed
local lombok_path = mason_path .. "/packages/jdtls/lombok.jar"

-- 3. The Main Configuration
local config = {
  cmd = {
    -- The command to start the language server
    "java", 
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    
    -- IMPORTANT: Load Lombok (for getters/setters)
    "-javaagent:" .. lombok_path,

    -- The jar file that launches the server
    "-jar", launcher_jar,

    -- The configuration folder for your OS
    "-configuration", config_path,

    -- The workspace folder for this specific project
    "-data", workspace_dir
  },

  -- 4. Root Directory Detection
  --    This tells the server where your project root is (looks for .git, mvnw, or gradlew)
  root_dir = jdtls_setup.find_root({'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'}),

  -- 5. Attach your keybindings (optional but recommended)
  --    If you have a common 'on_attach' function in your lsp config, use it here.
  --    Otherwise, we just hook up the defaults.
  on_attach = function(client, bufnr)
    -- Enable completion trigger
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Standard Keymaps (GD, K, etc.)
    local opts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>K', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  end,
  
  -- 6. Setup capabilities for nvim-cmp (Autocompletion)
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  
  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' }, -- Use powerful decompiler
    }
  }
}

-- 7. Start the Server
jdtls.start_or_attach(config)
