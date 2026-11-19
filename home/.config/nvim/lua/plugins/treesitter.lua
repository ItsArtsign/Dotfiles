-- Tree-sitter: real syntax trees → accurate highlighting (and smarter text objects).
-- Parsers are compiled locally; that needs the `tree-sitter` CLI (pacman: tree-sitter-cli).
-- Without it, the parsers bundled with Neovim still work (lua, vim, vimdoc, c, markdown, query).
local parsers = {
  "java", "kotlin", "groovy", "lua", "luadoc", "vim", "vimdoc", "query", "bash", "fish",
  "json", "yaml", "toml", "xml", "properties", "markdown", "markdown_inline", "html", "css",
  "javascript", "typescript", "python", "rasi", "gitcommit", "git_rebase", "diff", "regex",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    if vim.fn.executable("tree-sitter") == 1 then
      require("nvim-treesitter").install(parsers) -- async; already-installed ones are skipped
    end
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
      callback = function(ev) pcall(vim.treesitter.start, ev.buf) end,
    })
  end,
}
