-- Looks: colorscheme, statusline, which-key (the "what can I press?" popup)
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      term_colors = true,
      integrations = {
        blink_cmp = true,
        gitsigns = true,
        mason = true,
        which_key = true,
        mini = { enabled = true },
        snacks = { enabled = true, indent_scope_color = "mauve" },
        native_lsp = { enabled = true },
      },
      -- match the desktop: mauve borders like the active Hyprland window
      custom_highlights = function(c)
        return {
          FloatBorder = { fg = c.mauve, bg = c.mantle },
          NormalFloat = { bg = c.mantle },
          FloatTitle = { fg = c.base, bg = c.mauve, style = { "bold" } },
          BlinkCmpMenuBorder = { fg = c.mauve, bg = c.mantle },
          BlinkCmpDocBorder = { fg = c.mauve, bg = c.mantle },
          BlinkCmpSignatureHelpBorder = { fg = c.mauve, bg = c.mantle },
          BlinkCmpMenu = { bg = c.mantle },
          BlinkCmpMenuSelection = { fg = c.base, bg = c.mauve, style = { "bold" } },
          WinSeparator = { fg = c.surface1 },
          CursorLineNr = { fg = c.mauve, style = { "bold" } },
        }
      end,
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "auto",
        globalstatus = true,
        section_separators = "",          -- square blocks, no powerline arrows
        component_separators = "│",
        disabled_filetypes = { statusline = { "snacks_dashboard" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { { "filename", path = 1, symbols = { modified = " ●", readonly = " " } }, "diagnostics" },
        lualine_x = { "lsp_status", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      win = { border = "single" },
      spec = {
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>q", group = "quit" },
        { "<leader>s", group = "search" },
        { "<leader>u", group = "toggle" },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "goto" },
        { "gs", group = "surround" },
      },
    },
    keys = {
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Keys for this buffer" },
    },
  },

  { "nvim-tree/nvim-web-devicons", lazy = true },
}
