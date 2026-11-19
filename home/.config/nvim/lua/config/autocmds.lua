local au = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup("user", { clear = true })

-- Flash the text you just yanked
au("TextYankPost", { group = group, callback = function() vim.hl.on_yank() end })

-- Reopen files where you left off
au("BufReadPost", {
  group = group,
  callback = function(ev)
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(ev.buf) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close help/man/quickfix etc. with just q
au("FileType", {
  group = group,
  pattern = { "help", "man", "qf", "checkhealth", "lspinfo" },
  callback = function(ev)
    vim.bo[ev.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = ev.buf, silent = true })
  end,
})

-- Equalize splits when the window (kitty) is resized
au("VimResized", { group = group, command = "tabdo wincmd =" })

-- Diagnostics look
vim.diagnostic.config({
  severity_sort = true,
  virtual_text = { spacing = 2, prefix = "■" },
  float = { border = "single", source = true },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
})
