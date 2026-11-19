-- Core keymaps (no plugins needed). Plugin keymaps live next to their plugin.
-- Convention: <leader>f = find, s = search, c = code, g = git, b = buffer, u = toggles
local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
map({ "n", "i", "x" }, "<C-s>", "<cmd>write<cr><esc>", { desc = "Save file" })

-- Windows: Ctrl+h/j/k/l to move between splits
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })
map("n", "<leader>-", "<C-w>s", { desc = "Split below" })
map("n", "<leader>|", "<C-w>v", { desc = "Split right" })
map("n", "<leader>w", "<C-w>", { desc = "Window…", remap = true })

-- Buffers (= open files, like IntelliJ editor tabs)
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to last buffer" })

-- Move selected lines up/down (IntelliJ: Alt+Shift+Up/Down)
map("x", "<M-j>", ":m '>+1<cr>gv=gv", { desc = "Move lines down" })
map("x", "<M-k>", ":m '<-2<cr>gv=gv", { desc = "Move lines up" })
map("n", "<M-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<M-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })

-- Keep selection when indenting
map("x", "<", "<gv")
map("x", ">", ">gv")

-- Diagnostics (errors/warnings): ]d / [d jump, <leader>cd shows the message
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })

-- Terminal mode: double Esc to get back to normal mode
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })
