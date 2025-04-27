return {
  -- add Monokai, Material, OneNord, Onedark, twp types of OneDark Pro and Atom themes
  { "loctvl842/monokai-pro.nvim" },
  { "marko-cerovac/material.nvim" },
  { "rmehri01/onenord.nvim", name = "onenord" },
  -- add onedark
  {
    "navarasu/onedark.nvim",
    -- priority = 1000, -- Ensure it loads first
  },
  { "shaunsingh/nord.nvim", name = "nord" },
  -- add onedarkpro "Lazy" get loaded via cs = "onedark"
  {
    "olimorris/onedarkpro.nvim",
    name = "onedarkpro_olimorris",
    -- priority = 1000 -- Ensure it loads first
  },
  -- Adding ayu - kind of like ayu-mirage
  { "Shatur/neovim-ayu" },
  -- add onedarker
  { "lunarvim/onedarker.nvim" },
  -- add catppuccin colorscheme
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  -- add gruvbox themes
  -- adding TJ colorbuddy
  { "tjdevries/colorbuddy.vim" }, -- this now also includes gruvbuddy
  { "luisiacc/gruvbox-baby" },
  { "sainnhe/gruvbox-material" },
  { "ellisonleao/gruvbox.nvim" },
  -- add tokyonight
  { "folke/tokyonight.nvim", priority = 1000, opts = { style = "storm" } }, -- available opts: style = moon|night|day|storm,
  -- configure LazyVim to load yr preferred colorscheme
  {
    "LazyVim/LazyVim", -- think this will override all of the above
    opts = {
      colorscheme = "tokyonight", -- "gruvbox", or "tokyonight",
      style = "storm", -- "baby" or "material" for gruvbox -- "storm", ... for tokyonight, "frappe", ... for catppuccin
    },
  },
}
