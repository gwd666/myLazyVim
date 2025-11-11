return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_strict_ssl = false
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = false,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accecpt_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        panel = {
          -- enabled = false,
          hover = true,
          window = { width = 60, rounded = true },
          auto_refresh = true,
        },
        filetypes = {
          python = true,
          julia = true,
          lua = true,
          r = true,
          cpp = true,
          c = true,
          zig = true,
          javascript = true,
          ["*"] = false, -- disable for oll other filetypes
        },
      })
    end,
  },
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   config = function()
  --     require("copilot-cmp").setup({
  --       sources = {
  --         name = "copilot",
  --         group_index = 1,
  --       },
  --       -- other sources
  --       { name = "nvim_lsp", group_index = 2 },
  --       { name = "path", group_index = 2 },
  --       { name = "buffer", group_index = 2 },
  --       { name = "treesitter", group_index = 2 },
  --       { name = "luasnip", group_index = 2 },
  --       { name = "cmp-treesitter", group_index = 2 },
  --     })
  --   end,
  -- },
  { "renerocksai/telekasten.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
  -- adding calendar to telekasten.nvim
  {
    "nvim-telekasten/calendar-vim",
    after = "telekasten.nvim",
  },
  -- better whitespaces showing
  { "ntpeters/vim-better-whitespace" },
  -- ctrlspace for Tab management
  { "vim-ctrlspace/vim-ctrlspace" },
  -- adding julia-vim support, mainly eg for \alpha to insert unicode
  { "juliaEditorSupport/julia-vim" },
  -- add zig.vim
  { "ziglang/zig.vim" },
}
