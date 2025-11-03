return {
  "swaits/zellij-nav.nvim",
  lazy = true,
  event = "VeryLazy",
  config = function()
    require("zellij-nav").setup()
    require("config.zellij-nav")
    if vim.env.ZELLIJ_SESSION_NAME then
      vim.keymap.set("n", "<c-h>", "<cmd>ZellijNavigateLeft<cr>", { silent = true, desc = "navigate left or tab" })
      vim.keymap.set("n", "<c-j>", "<cmd>ZellijNavigateDown<cr>", { silent = true, desc = "navigate down" })
      vim.keymap.set("n", "<c-k>", "<cmd>ZellijNavigateUp<cr>", { silent = true, desc = "navigate up" })
      vim.keymap.set("n", "<c-l>", "<cmd>ZellijNavigateRightTab<cr>", { silent = true, desc = "navigate right or tab" })
    end
  end,
}
