return {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  build = "make tiktoken",
  opts = {
    chat = {
      keymaps = {
        scroll_up = "<C-u>",
        scroll_down = "<C-d>",
      },
    },
    window = {
      layout = "vertical", -- vertical (default), horizontal, float, replace
      relative = "editor", -- editor (default), win, cursor, mouse
      border = "rounded", -- single (default), double, rounded, solid, shadow
      blend = 30, -- transparency (0 for fully opaque; 100 for fully transparent)
    },
  },
}
