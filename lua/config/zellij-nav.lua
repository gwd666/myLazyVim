if vim.fn.executable("zellij") == 1 and vim.env.ZELLIJ_SESSION_NAME and not vim.env.TMUX_PANE then
  -- NOTE: Ensures that when exiting NeoVim, Zellij returns to normal mode
  vim.api.nvim_create_autocmd("VimLeave", {
    pattern = "*",
    command = "silent !zellij action switch-mode normal",
  })
end
