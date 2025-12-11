return {
  -- add Monokai, Material, Nord, OneNord, OneDark Pro and Atom themes
  { "loctvl842/monokai-pro.nvim" },
  { "marko-cerovac/material.nvim" },
  -- add nord theme
  { "shaunsingh/nord.nvim", name = "nord" },
  -- add onenord
  { "rmehri01/onenord.nvim", branch = "main", name = "onenord" },
  {
    -- add onedark
    "navarasu/onedark.nvim",
    -- priority = 1000, -- Ensure it loads first
  },
  {
    "olimorris/onedarkpro.nvim",
    -- priority = 1000 -- Ensure it loads first
  },
  -- Adding ayu - kind of like ayu-mirage
  { "Shatur/neovim-ayu" },
  -- add onedarker
  { "lunarvim/onedarker.nvim" },
  -- add catppuccin colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
      blink_cmp = true,
    },
  },
  -- add tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 1000,
    opts = function()
      return {
        -- style = "storm",
        -- available style opts: style = moon|night|day|storm,
        transparent = true,
        -- styles = {
        --   sidebars = "transparent",
        --   floats = "transparent",
        -- },
      }
    end,
  },
  -- add gruvbox themes
  { "luisiacc/gruvbox-baby" },
  { "sainnhe/gruvbox-material" },
  { "ellisonleao/gruvbox.nvim" },
  -- add matrix theme
  { "iruzo/matrix-nvim" },
  -- adding TJ colorbuddy
  { "tjdevries/colorbuddy.vim" }, -- this now also includes gruvbuddy
}
