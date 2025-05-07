-- my personal plugin to change configs etc, besides the colorscheme and keymappings plugins files
return {
  -- add github/copilot -> nope use zbirenbaum/copilot.lua
  -- { "github/copilot.vim" },
  -- add zbirenbaum copilot.lua seems to be the better one
  -- this is managed via LazyExtras now
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter", --  INFO: the CopilotChat is managed in the Neovim EXTRAS!
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
  -- add lspkind for VSCode like pictograms-
  { "onsails/lspkind.nvim" },
  -- add iron.nvim TERM/REPL - there's a seperate iron.lua file in plugings folder
  -- add send-to-term
  -- { "mtikekar/nvim-send-to-term" },
  -- adding nvim-cmp for b/c of R-nvim
  { "hrsh7th/nvim-cmp", lazy = true },
  -- add some telescope extensions:
  {
    "nvim-telescope/telescope-project.nvim",
    requires = { { "nvim-lua//plenary.nvim" }, { "nvim-telescope/telescope.nvim" } },
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { { "nvim-lua//plenary.nvim" }, { "nvim-telescope/telescope.nvim" } },
  },
  -- add quarto-nvim
  { "quarto-dev/quarto-nvim" },
  --- add nnn.nvim for nnn tmux
  {
    "luukvbaal/nnn.nvim",
    config = function()
      require("nnn").setup()
    end,
  },
  -- add lualine-lsp-progress
  { "arkav/lualine-lsp-progress" },
  -- add lsp_staus
  {
    "nvim-lua/lsp-status.nvim",
  },
  -- adding harpoon - this is the original repo -- also handled by LazyExtras
  -- {
  --   "ThePrimeagen/harpoon",
  --   branch = "harpoon2",
  --   requires = { { "nvim-lua//plenary.nvim" }, { "nvim-telescope/telescope.nvim" } },
  --   config = function()
  --     require("harpoon").setup()
  --     require("telescope").load_extension("harpoon")
  --   end,
  -- },
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   main = "ibl",
  --   ---@module "ibl"
  --   ---@type ibl.config
  --   opts = {},
  -- },
  -- add zig.vim
  { "ziglang/zig.vim" },
  -- -- add rainbow-delimeters
  -- -- {
  -- --   "HiPhish/rainbow-delimiters.nvim",
  -- --   lazy = false,
  -- --   config = function()
  -- --     local rainbow = require("rainbow-delimiters")
  -- --     require("rainbow-delimiters.setup").setup({
  -- --       strategy = {
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
  -- add nvim-treesitter-textobjects
  -- { "nvim-treesitter/nvim-treesitter-textobjects" },
  -- add sql lsp extension
  -- { "nanotee/sqls.nvim" },
  -- add folke zen instaead of goyo
  -- { "folke/zen-mode.nvim" },
  -- add vim-devicons
  -- { "ryanoasis/vim-devicons" },
  -- add web-devicons for neo-tree
  -- { "nvim-tree/nvim-web-devicons", enabled = true },
  -- better whitespaces showing
  -- { "ntpeters/vim-better-whitespace" },
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
      require("chatgpt").setup({
        api_key_cmd = "gpg --decrypt /home/gwd/SER7_KEY-SHELL-GPT_OPENAI-API.gpg",
        edit_with_instructions = {
          keymaps = {
            toggle_help = "<M-h>", -- I changed it from <C-h> to <M-h> ie ALT+h like for other Telescope windows
          },
        },
        --     chat = {
        --       welcome_message = [[
        --         If you (gwd) don't ask the right questions,
        --         you don't get the right answers.
        --                                         ~ Robert Half
        -- ]],
        --   keymaps = {
        --     toggle_help = "<M-h>", -- I changed it from <C-g> to <M-h> ie ALT+h like for other Telescope windows
        --   },
        -- },
        openai_params = {
          model = "gpt-4o-mini",
          temperature = 0.1,
          max_tokens = 4096,
          frequency_penalty = 0,
          presence_penalty = 0,
          top_p = 0.2,
          n = 1,
        },
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim", -- optional
      "nvim-telescope/telescope.nvim",
    },
  },
  -- {
  --   "Julian/lean.nvim", -- from: https://github.com/Julian/lean.nvim
  --   event = { "BufReadPre *.lean", "BufNewFile *.lean" },
  --
  --   dependencies = {
  --     "neovim/nvim-lspconfig",
  --     "nvim-lua/plenary.nvim",
  --     -- you also will likely want nvim-cmp or some completion engine
  --   },
  --
  --   -- see details below for full configuration options
  --   opts = {
  --     lsp = {},
  --     mappings = true, -- enables default key mappings
  --   },
  -- },
  -- mason config is in lua/config/mason.lua
  -- {
  --   "WhoIsSethDaniel/mason-tool-installer.nvim",
  --   dependencies = { "mason.nvim" },
  -- },
}
