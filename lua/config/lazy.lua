-- start lazy.nvim load
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazyj.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import any extras modules here
    -- { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    { import = "lazyvim.plugins.extras.ui.mini-animate" },
    -- { import = "lazyvim.plugins.extras.ai.copilot" },
    -- { import = "lazyvim.plugins.extras.ai.copilot-chat" },
    -- import/override with your plugins
    { import = "plugins", concurrency = 30 },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax", "onenord", "gruvbox", "catppuccin" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  opts = {
    colorscheme = "catppuccin", -- "gruvbox", or "tokyonight",
    style = "frappe", -- "baby" or "material" for gruvbox -- "storm", ... for tokyonight, "frappe", ... for catppuccin
  },
})

-- set up indent-blankline
-- require("config.ibl")

-- make bat default previewer
require("fzf-lua").setup({ "telescope", winopts = { preview = { default = "bat" } } })

-- require("config.lualine")

require("config.lsp_status")

-- SET UP SOME COLOR SCHEMES
-- make some tokyonight setup mods
-- require("tokyonight").setup({
--   -- use the night style
--   style = "storm",
--   -- disable italic for functions
--   styles = {
--     functions = {},
--   },
--   sidebars = { "qf", "vista_kind", "terminal", "packer" },
--   -- Change the "hint" color to the "orange" color, and make the "error" color bright red
--   on_colors = function(colors)
--     colors.hint = colors.orange
--     colors.error = "#ff0000" -- red
--   end,
-- })

-- COMMENT OUT because of annoying warning about indent-blankline plugin
--
-- make Telescope borderless with tokyonight cs
require("tokyonight").setup({
  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  on_colors = function(colors)
    colors.hint = colors.orange
    colors.error = "#ff0000" -- red
  end,
  on_highlights = function(hl, c)
    local prompt = "#2d3149"
    hl.TelescopeNormal = {
      bg = c.bg_dark,
      fg = c.fg_dark,
    }
    hl.TelescopeBorder = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.TelescopePromptNormal = {
      bg = prompt,
    }
    hl.TelescopePromptBorder = {
      bg = prompt,
      fg = prompt,
    }
    hl.TelescopePromptTitle = {
      bg = prompt,
      fg = prompt,
    }
    hl.TelescopePreviewTitle = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
    hl.TelescopeResultsTitle = {
      bg = c.bg_dark,
      fg = c.bg_dark,
    }
  end,
})

-------------- catppuccin setup -----------------------
-- try to make Telescope borderless with catppuccin cs

local colors = require("catppuccin.palettes").get_palette()
local TelescopeColor = {
  TelescopeMatching = { fg = colors.flamingo },
  TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },

  TelescopePromptPrefix = { bg = colors.surface0 },
  TelescopePromptNormal = { bg = colors.surface0 },
  TelescopeResultsNormal = { bg = colors.mantle },
  TelescopePreviewNormal = { bg = colors.mantle },
  TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
  TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
  TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
  TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
  TelescopeResultsTitle = { fg = colors.mantle },
  TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
}

for hl, col in pairs(TelescopeColor) do
  vim.api.nvim_set_hl(0, hl, col)
end

require("catppuccin").setup({
  transparent_background = true, --false, -- if true nvim will be transparent!
  integrations = {
    cmp = true,
    nvimtree = true,
    treesitter = true,
    treesitter_context = true,
    notify = true, --false,
    neotree = true,
    mason = true,
    harpoon = true,
    telescope = true,
    telekasten = true,
    which_key = true,
  },
  color_ovcerrides = {
    frappe = { -- originally mocha was used here
      base = "#1c1917",
      blue = "#22d3ee",
      green = "#86efac",
      flamingo = "#D6409F",
      lavender = "#DE51A8",
      pink = "#f9a8d4",
      red = "#fda4af",
      maroon = "#f87171",
      mauve = "#D19DFF",
      text = "#E8E2D9",
      sky = "#7ee6fd",
      yellow = "#fde68a",
      rosewater = "#f4c2c2",
      peach = "#fba8c4",
      teal = "#4fd1c5",
    },
  },
})
