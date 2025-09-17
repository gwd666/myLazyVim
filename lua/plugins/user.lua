return {
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
