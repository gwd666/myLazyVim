return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  -- add onedark
  {
    "navarasu/onedark.nvim",
    -- priority = 1000, -- Ensure it loads first
  },
  -- add onedarkpro "Lazy" get loaded via cs = "onedark"
  {
    "olimorris/onedarkpro.nvim",
    -- priority = 1000 -- Ensure it loads first
  },
  -- add onedarker
  { "lunarvim/onedarker.nvim" },
  --add catppuccin
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  -- add tokyonight
  { "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = { style = "storm" } }, -- available opts: style = moon|night|day|storm,
  -- configure LazyVim to load yr preferred colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
      style = "storm", -- or gruvbox or catppuccin
    },
  },
}
