local custom_gruvbox = require("lualine.themes.gruvbox")

-- Change the background of lualine_c section for normal mode
custom_gruvbox.normal.c.bg = "#112233"

require("lualine").setup({
  -- options = { theme = "gruvbox" },
  options = { theme = custom_gruvbox },
  extensions = { "mason", "ctrlspace" },
  lualine_c = {
    "%=", -- make indicator center
    {
      "harpoon2",
      -- custom config:
      --   icon = "♥",
      --   indicators = { "a", "s", "q", "w" },
      --   active_indicators = { "A", "S", "Q", "W" },
      --   color_active = { fg = "#00ff00" },
      --   _separator = " ",
      --   no_harpoon = "Harpoon not loaded",
    },
  },
})
