return {
  "swaits/zellij-nav.nvim",
  enabled = function()
    return vim.fn.executable("zellij") == 1 and vim.env.ZELLIJ_SESSION_NAME and not vim.env.TMUX_PANE
  end,
  lazy = true,
  event = "VeryLazy",
  opts = {},
  config = function(_, opts)
    require("zellij-nav").setup(opts)
    require("config.zellij-nav")
    if vim.env.ZELLIJ_SESSION_NAME and not vim.env.TMUX_PANE then
      vim.keymap.set("n", "<c-h>", "<cmd>ZellijNavigateLeft<cr>", { silent = true, desc = "navigate left or tab" })
      vim.keymap.set("n", "<c-j>", "<cmd>ZellijNavigateDown<cr>", { silent = true, desc = "navigate down" })
      vim.keymap.set("n", "<c-k>", "<cmd>ZellijNavigateUp<cr>", { silent = true, desc = "navigate up" })
      vim.keymap.set("n", "<c-l>", "<cmd>ZellijNavigateRightTab<cr>", { silent = true, desc = "navigate right or tab" })
    end
  end,
}
