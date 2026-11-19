-- :help option-list  (or <Space>sh and search an option name)
local o = vim.opt

-- Look
o.number = true             -- line numbers…
o.relativenumber = true     -- …relative, so "5j" / "12k" jumps are easy to read off
o.cursorline = true
o.signcolumn = "yes"        -- always show the gutter (no jumping when git/diagnostic signs appear)
o.termguicolors = true
o.showmode = false          -- lualine shows the mode
o.laststatus = 3            -- one global statusline
o.winborder = "single"      -- SQUARE borders on every floating window (hover, diagnostics, …)
o.fillchars = { eob = " ", vert = "│" }
o.list = true
o.listchars = { tab = "→ ", trail = "·", nbsp = "␣" }
o.scrolloff = 8             -- keep 8 lines visible above/below the cursor
o.sidescrolloff = 8
o.wrap = false
o.pumheight = 12

-- Editing
o.expandtab = true          -- spaces, 4 wide (Java default)
o.shiftwidth = 4
o.tabstop = 4
o.smartindent = true
o.undofile = true           -- undo history survives closing the file
o.confirm = true            -- ask instead of failing on :q with unsaved changes
o.clipboard = "unnamedplus" -- yank/paste use the system clipboard (wl-copy)
o.mouse = "a"               -- mouse works, but try not to need it :)
o.virtualedit = "block"     -- Ctrl+v block selection can go past line ends

-- Search
o.ignorecase = true
o.smartcase = true          -- …unless the search has a capital letter
o.inccommand = "split"      -- live preview of :%s/foo/bar/

-- Windows / timing
o.splitright = true
o.splitbelow = true
o.updatetime = 250
o.timeoutlen = 400          -- which-key popup delay
