-- my personal plugin to change configs etc, besides the colorscheme and keymappings plugins files
return {
  -- add github/copilot
  -- { "github/copilot.vim" },
  -- add zbirenbaum copilot.lua seems to be the better one
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter", --  INFO: the CopilotChat is managed in the Neovim EXTRAS!
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
  -- add lspkind for VSCode like pictograms-
  { "onsails/lspkind.nvim" },
  -- add iron.nvim TERM/REPL - there's a seperate iron.lua file in plugings folder
  -- add send-to-term
  -- { "mtikekar/nvim-send-to-term" },
  -- add some telescope extensions:
  { "nvim-telescope/telescope-project.nvim" },
  { "nvim-telescope/telescope-file-browser.nvim" },
  -- add quarto-nvim
  { "quarto-dev/quarto-nvim" },
  --- add nnn.nvim for nnn tmux
  {
    "luukvbaal/nnn.nvim",
    config = function()
      require("nnn").setup()
    end,
  },
  -- adding harpoon - this is the original repo
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { { "nvim-lua//plenary.nvim" }, { "nvim-telescope/telescope.nvim" } },
    config = function()
      require("harpoon").setup()
      require("telescope").load_extension("harpoon")
    end,
  },
  -- { -- this is my fork with slightly diff keymappings
  --   "gwd666/harpoon", -- switch to my fork to avoid C-d mapping
  --   branch = "harpoon2",
  --   requires = { { "nvim-lua//plenary.nvim" }, { "nvim-telescope/telescope.nvim" } },
  --   config = function()
  --     require("harpoon").setup()
  --     require("telescope").load_extension("harpoon")
  --   end,
  -- },
  -- add zig.vim
  { "ziglang/zig.vim" },
  -- add rainbow-delimeters
  {
    "HiPhish/rainbow-delimiters.nvim",
    lazy = false,
    config = function()
      local rainbow = require("rainbow-delimiters")
      require("rainbow-delimiters.setup").setup({
        strategy = {
          [""] = rainbow.strategy["global"],
          vim = rainbow.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
          python = "rainbow-blocks",
          r = "rainbow-blocks",
          -- julia = "rainbow-delimiters",
          julia = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
        blacklist = { "cpp" },
      })
    end,
  },
  -- add nvim-treesitter-textobjects
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  -- add sql lsp extension
  { "nanotee/sqls.nvim" },
  -- add folke zen instaead of goyo
  { "folke/zen-mode.nvim" },
  -- add vim-devicons
  -- { "ryanoasis/vim-devicons" },
  -- add web-devicons for neo-tree
  { "nvim-tree/nvim-web-devicons", enabled = true },
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
  -- { "madox2/vim-ai" },
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
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason.nvim" },
  },
}
