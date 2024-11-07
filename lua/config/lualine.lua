-- local custom_gruvbox = require("lualine.themes.gruvbox")
-- local custom_nord = require("lualine.themes.nord")

-- Change the background of lualine_c section for normal mode
-- custom_gruvbox.normal.c.bg = "#112233"
-- custom_nord.normal.c.bg = "#112233"

require("lualine").setup({
  -- options = { theme = "onelight" },
  -- options = { theme = "onenord" },
  options = { theme = "nord" },
  -- options = { theme = custom_nord },
  -- options = { theme = "material" },
  -- options = { theme = "gruvbox" },
  -- options = { theme = "gruvbox_dark" },
  -- options = { theme = "gruvbox_light" },
  -- options = { theme = "gruvbox-material" },
  -- options = { theme = custom_gruvbox },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { "filename" },
    lualine_d = { "lsp_progress" },
    -- lualine_d = { { lsp_progress = { spinner = "⠋" } } },
    lualine_e = { { "diagnostics", sources = { "nvim" } } },
    -- lualine_d = { "lsp_progress" },
    lualine_w = { require("lsp-status").status() },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})

-- Example config for nord theme - in lua
vim.g.nord_contrast = true
-- vim.g.nord_contrast = false
vim.g.nord_borders = false
vim.g.nord_disable_background = false
vim.g.nord_italic = false
vim.g.nord_uniform_diff_background = true
vim.g.nord_bold = false

-- require("lazy").setup({
--   {
--     "lukas-reineke/headlines.nvim",
--     dependencies = "nvim-treesitter/nvim-treesitter",
--     config = true, -- or `opts = {}`
--   },
-- })

-- bufferline tweasks for highliting for the active buffer
local highlights = require("nord").bufferline.highlights({
  italic = true,
  bold = true,
  fill = "#181c24",
})
-- adding slant separator
require("bufferline").setup({
  options = {
    separator_style = "slant",
    -- separator_style = "thin", -- the classic thin one
  },
  highlights = highlights,
})
-- to add headlines for md files support
require("headlines").setup({
  markdown = {
    headline_highlights = {
      "Headline1",
      "Headline2",
      "Headline3",
      "Headline4",
      "Headline5",
      "Headline6",
    },
    codeblock_highlight = "CodeBlock",
    dash_highlight = "Dash",
    quote_highlight = "Quote",
  },
})

-- Load the colorscheme
-- require("nord").set()
