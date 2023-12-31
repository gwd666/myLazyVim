-- my personal plugin to change configs etc, besides the colorscheme and keymappings plugins files
return {
  -- add github/copilot
  -- { "github/copilot.vim" },
  -- add zbirenbaum copilot.lua
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = {
          -- enabled = false,
          -- other options
          auto_refresh = true,
        },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  -- add lspkind for VSCode like pictograms-
  { "onsails/lspkind.nvim" },
  -- add iron.nvim TERM/REPL - there's a seperate iron.lua file in plugings folder
  -- { "hkupty/iron.nvim", lazy = false },
  -- add send-to-term
  -- { "mtikekar/nvim-send-to-term" },
  -- add quarto-nvim
  { "quarto-dev/quarto-nvim" },
  --- add nnn.nvim for nnn tmux
  {
    "luukvbaal/nnn.nvim",
    config = function()
      require("nnn").setup()
    end,
  },
  -- add vim-ai
  { "madox2/vim-ai" },
  -- add folke zen instaead of goyo
  { "folke/zen-mode.nvim" },
  -- add vim-devicons
  { "ryanoasis/vim-devicons" },
  -- add web-devicons({ "nvim-tree/nvim-web-devicons", enabled = false })
  -- better whitespaces showing
  { "ntpeters/vim-better-whitespace" },
  -- add telekasten
  { "renerocksai/telekasten.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
  -- adding calendar to telekasten.nvim
  { "renerocksai/calendar-vim" },
  -- add gruvbox themes
  { "luisiacc/gruvbox-baby" },
  { "sainnhe/gruvbox-material" },
  -- add Monokai, Material, OneDark Pro and Atom themes
  { "loctvl842/monokai-pro.nvim" },
  { "rmehri01/onenord.nvim" },
  { "marko-cerovac/material.nvim" },
  { "olimorris/onedarkpro.nvim" },
  -- add catppuccin colorscheme
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  -- change mason config
  -- trying to change mason ui iconvs - naaa not working - todo
  {
    "mason.nvim",
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  },
}
