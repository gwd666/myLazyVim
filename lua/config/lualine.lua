-- local custom_gruvbox = require("lualine.themes.gruvbox")
-- local custom_nord = require("lualine.themes.nord")

-- -- Change the background of lualine_c section for normal mode
-- custom_gruvbox.normal.c.bg = "#112233"
-- custom_nord.normal.c.bg = "#112233"
-- local function hello()
--   return [[hello world]]
-- end
--
require("lualine").setup({
  -- options = { theme = "onelight" },
  options = { theme = "tokyonight" },
  -- options = { theme = "onenord" },
  -- options = { theme = "nord" },
  -- options = { theme = custom_nord },
  -- options = { theme = "material" },
  -- options = { theme = "gruvbox" },
  -- options = { theme = "gruvbox_dark" },
  -- options = { theme = "gruvbox_light" },
  -- options = { theme = "gruvbox-material" },
  -- options = { theme = custom_gruvbox },
  sections = {
    --   lualine_a = { "mode" },
    --   lualine_b = { "branch", "diff" },
    --   -- lualine_b = { "diff" },
    --   lualine_c = { "filename", "filesize" }, -- fot testing purposes you could eg call hello func in here w/o quotes and :so %
    --   lualine_c = { { "diagnostics", sources = { "nvim" } } },
    --   lualine_x = { "lsp_status" },
    --   -- lualine_x = { "lsp_progress" },
    --   -- lualine_z = { { lsp_progress = { spinner = "⠋" } } },
    --   -- lualine_z = { require("lsp-status").status() },
    lualine_x = {
      "encoding",
      "fileformat",
      "filetype",
    },
    -- lualine_y = { "searchcount" }
    -- lualine_y = { "lsp_status", "lsp_progress" },
    --   lualine_z = { "progress", "location" }, -- row and col location
  },
})

-- require("lualine").setup({
--   options = {
--     theme = "ayu",
--   },
-- })

-- -- Example config for nord theme - in lua
-- vim.g.nord_contrast = true
-- -- vim.g.nord_contrast = false
-- vim.g.nord_borders = false
-- vim.g.nord_disable_background = false
-- vim.g.nord_italic = false
-- vim.g.nord_uniform_diff_background = true
-- vim.g.nord_bold = false
--
-- require("lazy").setup({
--   {
--     "lukas-reineke/headlines.nvim",
--     dependencies = "nvim-treesitter/nvim-treesitter",
--     config = true, -- or `opts = {}`
--   },
-- })

-- bufferline tweaks for highliting for the active buffer
-- local highlights = require("nord").bufferline.highlights({
--   italic = true,
--   bold = true,
--   fill = "#181c24",
-- })

-- adding slant separator
require("bufferline").setup({
  options = {
    separator_style = "slant",
    -- separator_style = "thin", -- the classic thin one
  },
  highlights = highlights,
})

-- Load the colorscheme
-- require("nord").set()
