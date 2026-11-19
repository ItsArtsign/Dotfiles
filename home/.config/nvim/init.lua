-- ┌──────────────────────────────────────────────────────────────┐
-- │ Neovim — sharp Catppuccin Mocha                              │
-- │ Load order: options → keymaps → autocmds → plugins (lazy)    │
-- │ Plugin specs live in lua/plugins/*.lua (one topic per file)  │
-- │ Press <Space> and wait: which-key shows every binding.       │
-- └──────────────────────────────────────────────────────────────┘
vim.g.mapleader = " "        -- <leader> = Space (must be set before plugins load)
vim.g.maplocalleader = "\\"

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
