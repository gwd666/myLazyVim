local custom_gruvbox = require("lualine.themes.tokyonight")

-- Change the background of lualine_c section for normal mode
custom_gruvbox.normal.c.bg = "#112233"

require("lualine").setup({
  -- options = { theme = "gruvbox" },
  options = { theme = custom_gruvbox },
  extensions = { "mason", "ctrlspace" },
  lualine_c = {
    "filename",
    "venv-selector",
    "%=", -- make indicator center
    {
      "harpoon2",
      -- custom config:
      icon = "♥",
      indicators = { "a", "s", "q", "w" },
      active_indicators = { "A", "S", "Q", "W" },
      color_active = { fg = "#00ff00" },
      _separator = " ",
      no_harpoon = "Harpoon not loaded",
    },
  },
})

-- -- default lualine sections config exmaple
-- sections = {
--     lualine_a = {'mode'},
--     lualine_b = {'branch', 'diff', 'diagnostics'},
--     lualine_c = {'filename'},
--     lualine_x = {'encoding', 'fileformat', 'filetype'},
--     lualine_y = {'progress'},
--     lualine_z = {'location'}
--   },
--   inactive_sections = {
--     lualine_a = {},
--     lualine_b = {},
--     lualine_c = {'filename'},
--     lualine_x = {'location'},
--     lualine_y = {},
--     lualine_z = {}
