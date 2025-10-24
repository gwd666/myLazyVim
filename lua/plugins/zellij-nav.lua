local function is_zellij_available_and_active()
  local session = vim.env.ZELLIJ_SESSION_NAME
  local zellij_exists = vim.fn.executable("zellij") == 1
  local result = session and zellij_exists
  return result
end

return {
  "swaits/zellij-nav.nvim",
  lazy = true,
  cond = is_zellij_available_and_active(),
  event = "VeryLazy",
  keys = {
    { "<c-h>", "<cmd>ZellijNavigateLeft<cr>", mode = "n", silent = true, desc = "navigate left or tab" },
    { "<c-j>", "<cmd>ZellijNavigateDown<cr>", mode = "n", silent = true, desc = "navigate down" },
    { "<c-k>", "<cmd>ZellijNavigateUp<cr>", mode = "n", silent = true, desc = "navigate up" },
    { "<c-l>", "<cmd>ZellijNavigateRightTab<cr>", mode = "n", silent = true, desc = "navigate right or tab" },
  },
  config = function()
    require("zellij-nav").setup()
    require("config.zellij-nav")
  end,
}
