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
          enabled = false,
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
  -- add lspkind for VSCode like pictograms
  { "onsails/lspkind.nvim" },
  -- add iron.nvim TERM/REPL - there's a seperate iron.lua file in plugings folder
  -- add some telescope extensions:
  { "nvim-telescope/telescope-project.nvim" },
  { "nvim-telescope/telescope-file-browser.nvim" },
  -- add send-to-term
  -- { "mtikekar/nvim-send-to-term" },
  -- add folke zen instaead of goyo
  { "folke/zen-mode.nvim" },
  -- add vim-devicons
  { "ryanoasis/vim-devicons" },
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
  -- add web-devicons
  { "nvim-tree/nvim-web-devicons", enabled = false },
  -- better whitespaces showing
  { "ntpeters/vim-better-whitespace" },
  -- add telekasten
  { "nvim-telekasten/telekasten.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
  -- adding calendar to telekasten.nvim
  {
    "nvim-telekasten/calendar-vim",
    after = "telekasten.nvim",
  },
  -- add madox2/vim-ai
  -- { "madox2/vim-ai"}
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
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
