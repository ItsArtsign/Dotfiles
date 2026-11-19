-- LSP = the "IDE brain": completion, go-to-definition, errors, rename, code actions.
-- Mason installs the servers (:Mason or <leader>cm). Java uses jdtls (Eclipse JDT, needs JDK 21+).
--
-- Built-in Neovim LSP keys you get for free:
--   K    hover docs          grn  rename           gra  code action
--   grr  references          gri  implementation   gO   file symbols
--   ]d [d  next/prev error   <C-s> (insert) signature help
return {
  { "mason-org/mason.nvim", cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonUninstall", "MasonLog" }, opts = { ui = { border = "single" } },
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason (LSP installer)" } } },

  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig", "saghen/blink.cmp" },
    config = function()
      -- every server gets blink.cmp's completion capabilities
      vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })
      require("mason").setup({ ui = { border = "single" } })
      require("mason-lspconfig").setup({
        ensure_installed = { "jdtls", "lua_ls", "jsonls", "yamlls", "bashls", "lemminx" },
        automatic_enable = true,
      })
    end,
  },

  -- Makes lua_ls understand the Neovim API while you edit this config
  { "folke/lazydev.nvim", ft = "lua", opts = { library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } } },

  -- Extra LSP keymaps, only active in buffers with a language server attached
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user_lsp", { clear = true }),
        callback = function(ev)
          local function map(lhs, rhs, desc, mode)
            vim.keymap.set(mode or "n", lhs, rhs, { buffer = ev.buf, desc = desc })
          end
          map("gd", function() Snacks.picker.lsp_definitions() end, "Go to definition")
          map("gD", vim.lsp.buf.declaration, "Go to declaration")
          map("gI", function() Snacks.picker.lsp_implementations() end, "Go to implementation")
          map("gy", function() Snacks.picker.lsp_type_definitions() end, "Go to type definition")
          map("<leader>cr", vim.lsp.buf.rename, "Rename symbol")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action", { "n", "x" })
          map("<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Format file", { "n", "x" })
          map("<leader>cR", function() Snacks.picker.lsp_references() end, "References")
          map("<leader>ss", function() Snacks.picker.lsp_symbols() end, "Symbols (file)")
          map("<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, "Symbols (project)")
          -- IntelliJ muscle memory
          map("<M-CR>", vim.lsp.buf.code_action, "Code action (IntelliJ Alt+Enter)", { "n", "i", "x" })
          map("<S-F6>", vim.lsp.buf.rename, "Rename (IntelliJ Shift+F6)")
          map("<C-M-l>", function() vim.lsp.buf.format({ async = true }) end, "Format (IntelliJ Ctrl+Alt+L)")
        end,
      })
    end,
  },
}
