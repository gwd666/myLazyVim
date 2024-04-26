return {
  -- add Monokai, Material, OneNord, OneDark Pro and Atom themes
  { "loctvl842/monokai-pro.nvim" },
  { "marko-cerovac/material.nvim" },
  -- add onedark
  { "rmehri01/onenord.nvim", name = "onenord" },
  {
    "navarasu/onedark.nvim",
    -- priority = 1000, -- Ensure it loads first
  },
  { "olimorris/onedarkpro.nvim" },
  -- add onedarkpro "Lazy" get loaded via cs = "onedark"
  {
    "olimorris/onedarkpro.nvim",
    -- priority = 1000 -- Ensure it loads first
  },
  -- add onedarker
  { "lunarvim/onedarker.nvim" },
  -- add catppuccin colorscheme
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  -- add gruvbox themes
  { "luisiacc/gruvbox-baby" },
  { "sainnhe/gruvbox-material" },
  { "ellisonleao/gruvbox.nvim" },
  -- add matrix theme
  { "iruzo/matrix-nvim" },
  -- adding TJ colorbuddy
  { "tjdevries/colorbuddy.vim" }, -- this now also includes gruvbuddy
  -- add tokyonight
  { "folke/tokyonight.nvim", priority = 1000, opts = { style = "storm" } }, -- available opts: style = moon|night|day|storm,
  -- configure LazyVim to load yr preferred colorscheme
  -- {
  --   "LazyVim/LazyVim", -- think this will override all of the above
  --   opts = {
  --     colorscheme = "tokyonight", -- "gruvbox", or "tokyonight",
  --     style = "storm", -- "baby" or "material" for gruvbox -- "storm", ... for tokyonight, "frappe", ... for catppuccin
  --   },
  -- },
}
