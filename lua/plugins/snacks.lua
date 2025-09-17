return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.config
  opts = {
    bigfile = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    quickfile = { enabled = true },
    terminal = {
      enabled = true,
      win = { style = "terminal" }, -- or terminal or scratch
      -- shell = { "/home/gwd/.local/bin/ghostty" }, -- ghostty - but this does not open integrated terminal but external
      -- shell = { "/mnt/c/program files/wezterm/wezterm.exe" }, -- wezterm is more stable than ghostty - but also opens as external term
    },
    lazygit = { enabled = true },
    dashboard = {
      -- enabled = true,
      -- {
      -- sections = {
      -- { section = "header" },
      -- { icon = " ", title = "keymaps", section = "keys", indent = 2, padding = 1 },
      -- { icon = " ", title = "recent files", section = "recent_files", indent = 2, padding = 1 },
      -- { icon = " ", title = "projects", section = "projects", indent = 2, padding = 1 },
      -- { section = "startup" },
      -- },
      sections = {
        { section = "header" },
        {
          pane = 2,
          section = "terminal",
          cmd = "colorscript -e square",
          height = 5,
          padding = 1,
        },
        { section = "keys", gap = 1, padding = 1 },
        { pane = 2, icon = " ", title = "recent files", section = "recent_files", indent = 2, padding = 1 },
        { pane = 2, icon = " ", title = "projects", section = "projects", indent = 2, padding = 1 },
        {
          pane = 2,
          icon = " ",
          title = "git status",
          section = "terminal",
          enabled = vim.fn.isdirectory(".git") == 1,
          cmd = "git status --short --branch --renames",
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = "startup" },
      },
    },
    -- statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        wo = { wrap = true }, -- wrap notifications
      },
    },
  },
}
