# My Neovim Configuration
## 🚀 Overview

- **Neovim Version:** 0.10.x+
- **Package Manager:** [lazy.nvim](https://github.com/folke/lazy.nvim)
- **Theme:** [Material.nvim (Darker)](https://github.com/marko-cerovac/material.nvim)
- **LSP/DAP:** [Mason.nvim](https://github.com/williamboman/mason.nvim) for easy tool management.
- **Notebooks:** [Molten-nvim](https://github.com/benlubas/molten-nvim) + [Jupytext](https://github.com/mwouts/jupytext) for Jupyter in Neovim.
- **AI:** [GitHub Copilot](https://github.com/github/copilot.vim) & [CopilotChat.nvim](https://github.com/CopilotC-Nvim/CopilotChat.nvim).

## 🛠 Requirements
### Core Dependencies
- **Neovim** (0.10.x or newer)
- **Git** (for plugin management)
- **C/C++ Compiler** (`gcc` or `clang` for Treesitter and C++ development)
- **Make** (required for `LuaSnip` and `CopilotChat`)
- **Node.js & npm** (required for many LSPs via Mason)
- **Python 3 & pip** (for `pynvim` and notebook support)
- **Ripgrep** (required for Telescope fuzzy search)

### Optional but Recommended
- **[Nerd Font](https://www.nerdfonts.com/)** (e.g., JetBrainsMono Nerd Font) for icons.
- **[Kitty](https://sw.kovidgoyal.net/kitty/)** Terminal (required for `image.nvim` backend).
- **[ImageMagick](https://imagemagick.org/)** (required for image rendering in notebooks).
- **[Zathura](https://pwmt.org/projects/zathura/)** (required for the integrated PDF viewer).
- **[LazyGit](https://github.com/jesseduffield/lazygit)** (for the `<leader>gg` shortcut).
- **[Jupytext](https://github.com/mwouts/jupytext)** (for notebook conversion, set path in `lua/plugins/notebook.lua`).

## 📥 Installation

1. **Clone the configuration:**
   ```bash
   git clone https://github.com/your-username/nvim-config.git ~/.config/nvim
   ```

2. **Setup Python Virtual Environment (for Molten-nvim):**
   This config expects a virtualenv at `~/.virtualenvs/neovim`.
   ```bash
   mkdir -p ~/.virtualenvs
   python3 -m venv ~/.virtualenvs/neovim
   source ~/.virtualenvs/neovim/bin/active
   pip install pynvim jupyter_client ipykernel
   deactivate
   ```

3. **Launch Neovim:**
   ```bash
   nvim
   ```
   `lazy.nvim` will automatically download and install all plugins.

4. **Install LSPs & Debuggers:**
   Open Neovim and run:
   ```vim
   :MasonInstall lua-language-server pyright clangd codelldb debugpy
   ```
   (Alternatively, `mason-lspconfig` will auto-install most of these on first use.)

## ⌨️ Keybindings

The **Leader** key is set to `Space`.

### 🪟 General & Windows
- `<leader> + |`: Split Vertical
- `<leader> + -`: Split Horizontal
- `Ctrl + h/j/k/l`: Move cursor between windows
- `Ctrl + Arrows`: Resize windows (Up/Down/Left/Right)
- `J` (Visual): Move selected lines down
- `K` (Visual): Move selected lines up
- `<leader> + p` (Visual): Paste over selected text (without losing current register)
- `Ctrl + \`: Toggle floating terminal
- `:w`: Save file

### 🔍 File Navigation & Search
- `Tab`: Toggle Neo-tree (File Explorer)
- `Ctrl + p`: Find Files (Telescope)
- `<leader> + fg`: Live Grep (Search for text across project)

### 💻 Development (LSP)
- `K`: Show Documentation (Hover)
- `gd`: Go to Definition
- `gi`: Go to Implementation
- `gr`: Go to References
- `<leader> + ca`: Code Actions
- `<leader> + rn`: Rename Symbol
- `<leader> + r`: **Run Code** (Supports C++, Python, Java with auto-save)

### 🐞 Debugging (DAP)
- `<leader> + db`: Toggle Breakpoint
- `<leader> + dc`: Start/Continue Debugging
- `<leader> + dx`: Close Debug UI
- `<leader> + du`: Clear all Breakpoints

### 📓 Notebooks (Molten & Jupytext)
- `<leader> + mi`: Initialize Molten
- `<localleader> + ip`: Initialize Molten for Python 3
- `<leader> + e`: Evaluate line or operator
- `<leader> + r` (Visual): Evaluate selection
- `<leader> + rc`: Re-evaluate entire cell
- `<leader> + nc`: Insert New Cell below (`# %%`)
- `]c` / `[c`: Jump to Next/Previous cell
- `<leader> + os`: Open output window
- `<leader> + oh`: Hide output window
- `<leader> + md`: Delete Molten cell

### 🤖 AI Assistant (Copilot)
- `Ctrl + j` (Insert): Accept Copilot Suggestion
- `<leader> + cc`: Toggle Copilot Chat window
- `<leader> + ce` (Visual): Explain Code
- `<leader> + cf` (Visual): Fix Code
- `Ctrl + s` (Chat): Submit prompt

### 🐙 Git
- `<leader> + gg`: Toggle LazyGit

## 📂 File Structure

```bash
~/.config/nvim
├── init.lua           # Entry point (Bootstrap lazy.nvim)
├── lazy-lock.json     # Plugin versions
├── ftplugin/          # Language-specific settings (Java/JDTLS)
└── lua/
    ├── vim-options.lua # General settings, keymaps, and run logic
    └── plugins/       # Plugin-specific configurations (lazy.nvim format)
```

## 🔌 Plugins Used

- **UI:** `material.nvim`, `lualine.nvim`, `neo-tree.nvim`, `mini.animate`, `indent-blankline.nvim`, `which-key.nvim`, `todo-comments.nvim`, `render-markdown.nvim`.
- **Fuzzy Finder:** `telescope.nvim`, `telescope-ui-select.nvim`.
- **LSP/Autocompletion:** `nvim-lspconfig`, `mason.nvim`, `mason-lspconfig.nvim`, `nvim-cmp`, `LuaSnip`, `friendly-snippets`.
- **DAP:** `nvim-dap`, `nvim-dap-ui`, `mason-nvim-dap.nvim`.
- **Languages:** `nvim-treesitter`, `nvim-jdtls`, `jupytext.nvim`, `molten-nvim`.
- **AI:** `copilot.vim`, `CopilotChat.nvim`.
- **Utilities:** `nvim-autopairs`, `nvim-surround`, `Comment.nvim`, `toggleterm.nvim`, `PDFview`, `image.nvim`.
