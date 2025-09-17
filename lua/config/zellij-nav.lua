if vim.fn.executable("zellij") == 1 then
  -- For lazy.nvim
  require("lazy").setup({
    { "willothy/nvim-zellij-nav" },
  })
end
