-- blink.cmp: completion popup — MANUAL only (no popup/ghost text while typing).
--   Ctrl+Space = open   Enter = accept   Ctrl+n / Ctrl+p (or arrows) = move   Ctrl+e = close
--   Tab / Shift+Tab = jump between snippet placeholders
return {
  "saghen/blink.cmp",
  version = "1.*",          -- release tags ship a prebuilt Rust fuzzy matcher
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = { "rafamadriz/friendly-snippets" },
  opts = {
    keymap = { preset = "enter" },
    appearance = { nerd_font_variant = "mono" },
    completion = {
      menu = { auto_show = false, border = "single" },   -- only opens on Ctrl+Space
      documentation = { auto_show = true, auto_show_delay_ms = 250, window = { border = "single" } },
      ghost_text = { enabled = false },
    },
    signature = { enabled = true, window = { border = "single" } },
    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
}
