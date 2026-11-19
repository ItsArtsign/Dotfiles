-- Editing helpers + learning aids
return {
  -- mini.ai: better text objects (e.g. "cif" = change inside function call args, "daa" = delete argument)
  -- mini.surround: gsa / gsd / gsr = add / delete / replace surrounding quotes, brackets, tags
  -- mini.pairs: auto-close brackets and quotes
  {
    "nvim-mini/mini.nvim",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.ai").setup()
      require("mini.pairs").setup()
      require("mini.surround").setup({
        mappings = { add = "gsa", delete = "gsd", replace = "gsr", find = "gsf", find_left = "gsF",
                     highlight = "gsh", update_n_lines = "gsn" },
      })
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = { add = { text = "▎" }, change = { text = "▎" }, delete = { text = "" },
                topdelete = { text = "" }, changedelete = { text = "▎" } },
      on_attach = function(buf)
        local gs = require("gitsigns")
        local function map(lhs, rhs, desc) vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc }) end
        map("]h", function() gs.nav_hunk("next") end, "Next git change")
        map("[h", function() gs.nav_hunk("prev") end, "Prev git change")
        map("<leader>gp", gs.preview_hunk, "Preview change")
        map("<leader>gr", gs.reset_hunk, "Revert change")
        map("<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
      end,
    },
  },

  -- LEARNING: shows where w/b/e/^/$/{/} would jump to, right in the buffer. Toggle with <leader>uh
  {
    "tris203/precognition.nvim",
    event = "VeryLazy",
    opts = {
      startVisible = false,                       -- off by default; <leader>uh when you want to study motions
      showBlankVirtLine = false,
      targetedMotionHints = { enabled = false },  -- no f/F/t/T letter soup
      gutterHints = {                             -- prio 0 = hidden: no gg/G/{/} in the number column
        G = { prio = 0 }, gg = { prio = 0 }, PrevParagraph = { prio = 0 }, NextParagraph = { prio = 0 },
      },
    },
    keys = { { "<leader>uh", function() require("precognition").toggle() end, desc = "Motion hints (learning)" } },
  },

  -- LEARNING: :VimBeGood = little games that drill movement
  { "ThePrimeagen/vim-be-good", cmd = "VimBeGood" },
}
