-- This is a config that can be merged with your
-- existing LazyVim config.
--
-- It configures all plugins necessary for quarto-nvim,
-- such as adding its code completion source to the
-- completion engine nvim-cmp.
-- Thus, instead of having to change your configuration entirely,
-- this takes your existings config and adds on top where necessary.

local wk = require("which-key")
return {
  -- this taps into vim.ui.select and vim.ui.input
  -- and in doing so currently breaks renaming in otter.nvim
  { "stevearc/dressing.nvim", enabled = false }, -- disbaled
  {
    "quarto-dev/quarto-nvim",
    opts = {
      lspFeatures = {
        languages = { "r", "python", "julia", "bash", "sql", "html", "lua" },
      },
    },
    ft = "quarto",
    keys = {
      wk.add({
        { "<leader>Q", group = "Quarto" },
        { "<leader>Qa", ":QuartoActivate<cr>", desc = "quarto activate" },
        { "<leader>Qp", ":lua require'quarto'.quartoPreview()<cr>", desc = "quarto preview" },
        { "<leader>Qq", ":lua require'quarto'.quartoClosePreview()<cr>", desc = "quarto close" },
        { "<leader>Qh", ":QuartoHelp ", desc = "quarto help" },
        { "<leader>Qe", ":lua require'otter'.export()<cr>", desc = "quarto export" },
        { "<leader>QE", ":lua require'otter'.export(true)<cr>", desc = "quarto export overwrite" },
        { "<leader>Qrr", ":QuartoSendAbove<cr>", desc = "quarto run to cursor" },
        { "<leader>Qra", ":QuartoSendAll<cr>", desc = "quarto run all" },
        { "<leader><cr>", ":SlimeSend<cr>", desc = "send code chunk" },
        { "<c-cr>", ":SlimeSend<cr>", desc = "send code chunk" },
        { "<c-cr>", "<esc>:SlimeSend<cr>i", mode = "i", desc = "send code chunk" },
        { "<c-cr>", "<Plug>SlimeRegionSend<cr>", mode = "v", desc = "send code chunk" },
        { "<cr>", "<Plug>SlimeRegionSend<cr>", mode = "v", desc = "send code chunk" },
        { "<leader>ctr", ":split term://R<cr>", desc = "terminal: R" },
        { "<leader>cti", ":split term://ipython<cr>", desc = "terminal: ipython" },
        { "<leader>ctp", ":split term://python<cr>", desc = "terminal: python" },
        { "<leader>ctj", ":split term://julia<cr>", desc = "terminal: julia" },
      }),
    },
  },

  {
    "jmbuhr/otter.nvim",
    opts = {
      buffers = {
        set_filetype = true,
      },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = { "jmbuhr/otter.nvim" },
    opts = function(_, opts)
      ---@param opts cmp.ConfigSchema
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "otter" } }))
    end,
  },

  -- send code from python/r/qmd documets to a terminal or REPL
  -- like ipython, R, bash
  {
    "jpalardy/vim-slime",
    init = function()
      vim.b["quarto_is_" .. "python" .. "_chunk"] = false
      Quarto_is_in_python_chunk = function()
        require("otter.tools.functions").is_otter_language_context("python")
      end

      vim.cmd([[
      let g:slime_dispatch_ipython_pause = 100
      function SlimeOverride_EscapeText_quarto(text)
        call v:lua.Quarto_is_in_python_chunk()
        if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk
          return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
        else
          return a:text
        end
      endfunction
      ]])

      local function mark_terminal()
        vim.g.slime_last_channel = vim.b.terminal_job_id
        vim.print(vim.g.slime_last_channel)
      end

      local function set_terminal()
        vim.b.slime_config = { jobid = vim.g.slime_last_channel }
      end

      -- slime, neovvim terminal
      vim.g.slime_target = "neovim"
      vim.g.slime_python_ipython = 1

      -- keybindings
      -- {
      --   { "<leader>cm", mark_terminal, desc = "mark terminal" },
      --   { "<leader>cs", set_terminal, desc = "set terminal" }
      -- }
      require("which-key").add({ -- instead of .register use .add now
        { "<leader>cm", mark_terminal, desc = "mark terminal" }, --new way to add keybindings
        { "<leader>cs", set_terminal, desc = "set terminal" },
        -- ["<leader>cm"] = { mark_terminal, "mark quarto terminal" },
        -- ["<leader>cs"] = { set_terminal, "set quarto terminal" },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        pyright = {},
        r_language_server = {},
        julials = {},
        marksman = {
          -- also needs:
          -- $home/.config/marksman/config.toml :
          -- [core]
          -- markdown.file_extensions = ["md", "markdown", "qmd"]
          filetypes = { "markdown", "quarto" },
          root_dir = require("lspconfig.util").root_pattern(".git", ".marksman.toml", "_quarto.yml"),
        },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "css",
        "html",
        "javascript",
        "json",
        "julia",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "r",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
    },
  },
}
