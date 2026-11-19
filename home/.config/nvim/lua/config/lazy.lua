-- lazy.nvim = plugin manager. :Lazy (or <leader>l) opens its UI.
-- Plugin versions are pinned in ~/.config/nvim/lazy-lock.json (committed in ~/.agents snapshots).
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath })
  if vim.v.shell_error ~= 0 then
    error("Failed to clone lazy.nvim:\n" .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = { { import = "plugins" } },
  install = { colorscheme = { "catppuccin" } },
  checker = { enabled = false },               -- no surprise update checks; update with :Lazy sync
  change_detection = { notify = false },
  rocks = { enabled = false },
  ui = { border = "single", backdrop = 100 },
  performance = {
    rtp = { disabled_plugins = { "gzip", "tarPlugin", "tohtml", "zipPlugin", "netrwPlugin" } },
  },
})

vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy (plugins)" })
