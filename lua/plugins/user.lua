return {
  { "renerocksai/telekasten.nvim", dependencies = { "nvim-telescope/telescope.nvim" } },
  -- adding calendar to telekasten.nvim
  {
    "nvim-telekasten/calendar-vim",
    after = "telekasten.nvim",
  },
  -- adding telescope-project.nvim (replacing project.nvim with it)
  {
    "nvim-telescope/telescope-project.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
  },
  -- better whitespaces showing
  { "ntpeters/vim-better-whitespace" },
  -- ctrlspace for Tab management
  { "vim-ctrlspace/vim-ctrlspace" },
  -- adding julia-vim support, mainly eg for \alpha to insert unicode
  { "juliaEditorSupport/julia-vim" },
  -- add zig.vim
  { "ziglang/zig.vim" },
  {
    "christoomey/vim-tmux-navigator",
    cond = function()
      return vim.fn.executable("tmux") == 1
    end,
    lazy = false,
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", mode = "n", desc = "Go to Left Window/Pane" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", mode = "n", desc = "Go to Lower Window/Pane" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", mode = "n", desc = "Go to Upper Window/Pane" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", mode = "n", desc = "Go to Right Window/Pane" },
    },
    init = function()
      vim.g.tmux_navigator_save_on_switch = 0
      vim.g.tmux_navigator_disable_when_zoomed = 0
      vim.g.tmux_navigator_preserve_zoom = 0
      vim.g.tmux_navigator_no_mappings = 1
    end,
  },
}
