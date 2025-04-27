-- my personal plugin to change configs etc, besides the colorscheme and keymappings plugins files
return {
  -- add github/copilot
  -- { "github/copilot.vim" },
  -- add zbirenbaum copilot.lua
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter", -- INFO: CopilotChat is managed in Neovim EXTRAS!
  --   config = function()
  --     require("copilot").setup({
  --       suggestion = { enabled = false },
  --       panel = {
  --         enabled = false,
  --         -- other options
  --         auto_refresh = true,
  --       },
  --     })
  --   end,
  -- },
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   after = { "copilot.lua" },
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end,
  -- },
  -- add rainbow-delimeters
  -- {
  --   "HiPhish/rainbow-delimiters.nvim",
  --   lazy = false,
  --   config = function()
  --     local rainbow = require("rainbow-delimiters")
  --     require("rainbow-delimiters.setup").setup({
  --       strategy = {
  --         [""] = rainbow.strategy["global"],
  --         vim = rainbow.strategy["local"],
  --       },
  --       query = {
  --         [""] = "rainbow-delimiters",
  --         lua = "rainbow-blocks",
  --         python = "rainbow-blocks",
  --         r = "rainbow-blocks",
  --         julia = "rainbow-blocks",
  --       },
  --       highlight = {
  --         "RainbowDelimiterRed",
  --         "RainbowDelimiterYellow",
  --         "RainbowDelimiterBlue",
  --         "RainbowDelimiterOrange",
  --         "RainbowDelimiterGreen",
  --         "RainbowDelimiterViolet",
  --         "RainbowDelimiterCyan",
  --       },
  --       blacklist = { "cpp" },
  --     })
  --   end,
  -- },
  -- add lspkind for VSCode like pictograms
  { "onsails/lspkind.nvim" },
  -- add iron.nvim TERM/REPL - there's a seperate iron.lua file in plugings folder
  -- add some telescope extensions:
  { "nvim-telescope/telescope-project.nvim" },
  { "nvim-telescope/telescope-file-browser.nvim" },
  -- add nvim-treesitter-textobjects
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  -- adding harpoon - this is the original repo
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { { "nvim-lua//plenary.nvim" }, { "nvim-telescope/telescope.nvim" } },
    init = function()
      -- require("harpoon").setup()
      require("telescope").load_extension("harpoon")
    end,
  },
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   main = "ibl",
  --   ---@module "ibl"
  --   ---@type ibl.config
  --   opts = {},
  -- },
  -- add zig.vim
  { "ziglang/zig.vim" },
  -- add rainbow-delimeters
  -- {
  --   "HiPhish/rainbow-delimiters.nvim",
  --   lazy = false,
  --   config = function()
  --     local rainbow = require("rainbow-delimiters")
  --     require("rainbow-delimiters.setup").setup({
  --       strategy = {
  --         [""] = rainbow.strategy["global"],
  --         vim = rainbow.strategy["local"],
  --       },
  --       query = {
  --         [""] = "rainbow-delimiters",
  --         lua = "rainbow-blocks",
  --         python = "rainbow-blocks",
  --         r = "rainbow-blocks",
  --         -- julia = "rainbow-delimiters",
  --         julia = "rainbow-blocks",
  --       },
  --       highlight = {
  --         "RainbowDelimiterRed",
  --         "RainbowDelimiterYellow",
  --         "RainbowDelimiterBlue",
  --         "RainbowDelimiterOrange",
  --         "RainbowDelimiterGreen",
  --         "RainbowDelimiterViolet",
  --         "RainbowDelimiterCyan",
  --       },
  --       blacklist = { "cpp" },
  --     })
  --   end,
  -- },
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
  -- {
  --   "WhoIsSethDaniel/mason-tool-installer.nvim",
  --   dependencies = { "mason.nvim" },
  -- },
}
