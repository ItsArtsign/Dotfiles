-- snacks.nvim: fuzzy picker, file explorer, dashboard, terminal, lazygit, notifications, toggles
local header = [[
███╗   ██╗██╗   ██╗██╗███╗   ███╗
████╗  ██║██║   ██║██║████╗ ████║
██╔██╗ ██║██║   ██║██║██╔████╔██║
██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]]

return {
  "folke/snacks.nvim",
  priority = 900,
  lazy = false,
  opts = {
    dashboard = { enabled = true, preset = { header = header } },
    picker = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true, style = "compact" },
    quickfile = { enabled = true },
    words = { enabled = true },     -- highlights other uses of the word under cursor; ]] / [[ jump
    statuscolumn = { enabled = true },
    terminal = { win = { border = "single" } },
    lazygit = { win = { border = "single" } },
    styles = {
      notification = { border = "single" },
      input = { border = "single" },
    },
  },
  keys = {
    -- The big three (IntelliJ: Ctrl+Shift+N, Ctrl+Shift+F, Ctrl+E)
    { "<leader><space>", function() Snacks.picker.files() end, desc = "Find files" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep (find in files)" },
    { "<leader>,", function() Snacks.picker.buffers() end, desc = "Open buffers" },
    { "<leader>e", function() Snacks.explorer() end, desc = "File explorer" },
    { "<M-1>", function() Snacks.explorer() end, desc = "File explorer (IntelliJ Alt+1)" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command history" },

    -- find
    { "<leader>ff", function() Snacks.picker.files() end, desc = "Files" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent files" },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Neovim config files" },

    -- search
    { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Word under cursor", mode = { "n", "x" } },
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "Lines in buffer" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Help pages" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>sc", function() Snacks.picker.commands() end, desc = "Commands" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics (project)" },
    { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Diagnostics (file)" },
    { "<leader>sr", function() Snacks.picker.resume() end, desc = "Resume last search" },
    { "<leader>sn", function() Snacks.notifier.show_history() end, desc = "Notification history" },

    -- git
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git status" },
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git log" },

    -- buffers / terminal
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Close buffer" },
    { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Close other buffers" },
    { "<M-F12>", function() Snacks.terminal() end, desc = "Terminal (IntelliJ Alt+F12)", mode = { "n", "t" } },
    { "<leader>t", function() Snacks.terminal() end, desc = "Terminal" },
    { "]]", function() Snacks.words.jump(1, true) end, desc = "Next reference" },
    { "[[", function() Snacks.words.jump(-1, true) end, desc = "Prev reference" },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative numbers" }):map("<leader>ul")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.inlay_hints():map("<leader>ui")
        Snacks.toggle.indent():map("<leader>ug")
      end,
    })
  end,
}
