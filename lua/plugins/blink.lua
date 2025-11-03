-- ~/.config/nvim/lua/plugins/blink.lua
-- (This file is loaded by LazyVim. We override "saghen/blink.cmp" here.)
return {
  -- Disable the official "blink-cmp-copilot" plugin (we'll use "blink.cmp" instead)
  { "giuxtaposition/blink-cmp-copilot", enabled = false },
  {
    "saghen/blink.cmp",
    dependencies = {
      "Exafunction/codeium.nvim",
      "fang2hou/blink-copilot",
      "moyiz/blink-emoji.nvim",
    },

    enable_cmp_source = function()
      return vim.g.ai_cmp
    end,

    virtual_text = {
      enabled = function()
        return not vim.g.ai_cmp
      end,
      key_bindings = {
        accept = false,
        next = "<M-]>",
        prev = "<M-[>",
      },
    },

    opts = {
      keymap = {
        preset = "super-tab",
        -- Disable <C-k> and <C-j> for blink completely so we can use them for cursor movement
        ["<C-k>"] = {},
        ["<C-j>"] = {},
      },
      sources = {
        default = { "lsp", "path", "snippets", "emoji", "buffer", "codeium", "copilot" },
        providers = {
          emoji = {
            module = "blink-emoji",
            name = "emoji",
            score_offset = 15,
            opts = { insert = true },
            should_show_items = function()
              return vim.tbl_contains({ "gitcommit", "markdown" }, vim.o.filetype)
            end,
          },

          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 500,
            async = true,
            transform_items = function(_, items)
              for _, item in ipairs(items) do
                item.kind_icon = ""
                item.kind_name = "Copilot"
              end
              return items
            end,
          },

          codeium = {
            name = "codeium",
            module = "codeium.blink",
            score_offset = 100,
            async = true,
            transform_items = function(_, items)
              for _, item in ipairs(items) do
                item.kind_icon = ""
                item.kind_name = "Codeium"
              end
              return items
            end,
          },
        },
      },

      completion = {
        keyword = { range = "full" },
        accept = { auto_brackets = { enabled = false } },

        list = {
          selection = {
            preselect = function(ctx)
              return vim.bo.filetype ~= "markdown"
            end,
          },
        },

        menu = {
          auto_show = false,
          draw = {
            columns = {
              { "label", "label_description", gap = 1 },
              { "kind_icon", "kind" },
            },
          },
        },

        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        ghost_text = { enabled = true },
      },
      -- signature help (enabled here, unchanged)
      signature = { enabled = true },
    },

    config = function(_, opts)
      require("blink-copilot").setup({
        max_completions = 4,
        max_attempts = 3,
      })
      opts.sources.providers.copilot.max_items = 3
      opts.sources.providers.codeium.max_items = 4

      require("blink.cmp").setup(opts)
      -- Set insert mode cursor movement keymaps
      vim.schedule(function()
        vim.keymap.set("i", "<C-k>", "<up>", { noremap = true, silent = true, desc = "Move cursor up" })
        vim.keymap.set("i", "<C-j>", "<down>", { noremap = true, silent = true, desc = "Move cursor down" })
      end)
    end,

    enabled = function()
      return not vim.tbl_contains({
        "markdown",
      }, vim.bo.filetype)
    end,

    cmdline = {
      enabled = true,
      completion = { ghost_text = { enabled = true } },
    },
  },
}
