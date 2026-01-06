vim.g.lspconfig_silent = 1
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "
vim.cmd("set number")
-- vim.cmd("set relativenumber")
vim.cmd("set cursorline")
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "white" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#ead84e" })
vim.api.nvim_set_option("clipboard", "unnamed")
vim.opt.hlsearch = true
vim.opt.incsearch = true
-- move selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- paste over highlight word
vim.keymap.set("x", "<leader>p", '"_dP')
--vim.opt.colorcolumn = "94"
vim.opt.clipboard = "unnamedplus"
-- wrap text
 vim.opt.swapfile = false
vim.opt.wrap = true
vim.opt.linebreak = true
-- vim.opt.breakindent = true
-- vim.opt.showbreak = "↳\\"
-- fk llm-ls
local notify_original = vim.notify
vim.notify = function(msg, ...)
    if
        msg
        and (
            msg:match("position_encoding param is required")
            or msg:match("Defaulting to position encoding of the first client")
            or msg:match("multiple different client offset_encodings")
        )
    then
        return
    end
    return notify_original(msg, ...)
end

-- Force Treesitter to start for these languages
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "lua", "python", "javascript", "html", "css" },
  callback = function()
    -- Try to start treesitter, but ignore errors if it fails
    pcall(vim.treesitter.start)
  end,
})

vim.opt.termguicolors = true -- Enable 24-bit RGB color

-- ROBUST RUN: Works from any directory
vim.keymap.set("n", "<leader>r", function()
  vim.cmd("w") -- Save

  local filetype = vim.bo.filetype
  
  -- 1. Get the Absolute Path of the file's folder
  --    %:p:h -> Present file, Full Path, Head (Directory only)
  local dir = vim.fn.expand("%:p:h") 
  
  -- 2. Get the filename only (e.g., "main.cpp")
  local filename = vim.fn.expand("%:t") 
  
  -- 3. Get the name without extension (e.g., "main")
  local name_no_ext = vim.fn.expand("%:t:r")

  if filetype == "cpp" then
    -- Command: cd /path/to/folder && g++ main.cpp -o main && ./main
    -- This ensures input/output files work correctly.
    vim.cmd("vsplit | term cd " .. dir .. " && g++ -g " .. filename .. " -o " .. name_no_ext .. " && ./" .. name_no_ext)

  elseif filetype == "python" then
    -- VENV LOGIC: Find venv in the PROJECT ROOT (where you opened nvim)
    local project_root = vim.fn.getcwd()
    local python_cmd = "python3" -- Default

    if vim.fn.executable(project_root .. "/venv/bin/python") == 1 then
      python_cmd = project_root .. "/venv/bin/python"
    elseif vim.fn.executable(project_root .. "/.venv/bin/python") == 1 then
      python_cmd = project_root .. "/.venv/bin/python"
    end

    -- Run Command: cd /path/to/folder && /path/to/venv/python main.py
    vim.cmd("vsplit | term cd " .. dir .. " && " .. python_cmd .. " " .. filename)
    
  else
    print("No run command for: " .. filetype)
  end
end, {})

-- SPLIT WINDOWS
vim.keymap.set("n", "<leader>|", ":vsplit<CR>", { desc = "Split Vertical" }) -- Space + sv
vim.keymap.set("n", "<leader>-", ":split<CR>", { desc = "Split Horizontal" }) -- Space + sh

-- NAVIGATE WINDOWS (Move cursor between panes)
vim.keymap.set("n", "<C-h>", "<C-w>h", {}) -- Ctrl + Left
vim.keymap.set("n", "<C-l>", "<C-w>l", {}) -- Ctrl + Right
vim.keymap.set("n", "<C-j>", "<C-w>j", {}) -- Ctrl + Down
vim.keymap.set("n", "<C-k>", "<C-w>k", {}) -- Ctrl + Up

-- RESIZE WINDOWS (Arrow keys to resize)
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", {})
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", {})
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", {})
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", {})
