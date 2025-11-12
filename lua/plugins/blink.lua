return {
  {
    "giuxtaposition/blink-cmp-copilot",
    enabled = false,
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "Exafunction/codeium.nvim",
      "fang2hou/blink-copilot",
      "moyiz/blink-emoji.nvim",
      -- opts = {
      --   max_completions = 1, -- Global default for max completions
      --   max_attempts = 2, -- Global default for max attempts
      -- },
    },
    -- Enables keymaps, completions and signature help when true (doesn't apply to cmdline or term)
    --
    -- If the function returns 'force', the default conditions for disabling the plugin will be ignored
    -- Default conditions: (vim.bo.buftype ~= 'prompt' and vim.b.completion ~= false)
    -- Note that the default conditions are ignored when `vim.b.completion` is explicitly set to `true`
    --
    -- Exceptions: vim.bo.filetype == 'dap-repl'

    -- This function must return true or false. If you want to enable AI
    -- completion only when `vim.g.ai_cmp == true`, keep this:
    enable_cmp_source = function()
      return vim.g.ai_cmp
    end,

    virtual_text = {
      enabled = function()
        return not vim.g.ai_cmp
      end,
      key_bindings = {
        accept = false, -- handled by nvim-cmp / blink.cmp
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
        -- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items
        default = { "lsp", "path", "snippets", "emoji", "buffer", "codeium", "copilot" },
        providers = {
          -- emoji setup - does not change/do much for now?
          emoji = {
            module = "blink-emoji",
            name = "emoji",
            score_offset = 15,
            opts = { insert = true },
            should_show_items = function()
              return vim.tbl_contains(
                -- Enable emoji completion only for these filetypes
                { "gitcommit", "markdown" },
                vim.o.filetype
              )
            end,
          },
          -- Copiilot setup
          copilot = {
            name = "copilot",
            -- blink-copilot config:
            module = "blink-copilot",
            score_offset = 500,
            async = true,
            transform_items = function(_, items)
              local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
              local kind_idx = #CompletionItemKind + 1
              CompletionItemKind[kind_idx] = "Copilot"

              for _, item in ipairs(items) do
                item.kind_icon = ""
                item.kind_name = "Copilot"
              end
              return items
            end,
          },
          -- Codeium setup
          codeium = {
            name = "codeium",
            module = "codeium.blink",
            kind = "Codeium",
            score_offset = 100,
            async = true,
            transform_items = function(_, items)
              local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
              local kind_idx = #CompletionItemKind + 1
              CompletionItemKind[kind_idx] = "Codeium"

              for _, item in ipairs(items) do
                item.kind_icon = ""
                item.kind_name = "Codeium"
              end
              return items
            end,
          },
        },
      },
    },

    completion = {
      -- 'prefix' will fuzzy match on the text before the cursor
      -- 'full' will fuzzy match on the text before _and_ after the cursor
      -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
      keyword = { range = "full" },
      -- Disable auto brackets
      -- NOTE: some LSPs may add auto brackets themselves anyway
      accept = { auto_brackets = { enabled = false } },

      -- Don't select by default, auto insert on selection
      -- list = { selection = { preselect = false, auto_insert = true } },
      -- or set via a function
      list = {
        selection = {
          preselect = function(ctx)
            return vim.bo.filetype ~= "markdown"
          end,
        },
      },

      -- ───────────────────────────────────────────────
      --   THIS is the crucial part:                   ──
      --   `menu` must have `draw` directly inside it. ──
      -- ───────────────────────────────────────────────
      menu = {
        auto_show = false, -- “Don’t pop up automatically”
        draw = {
          columns = {
            -- COLUMN 1: The actual text of the completion
            { "label", "label_description", gap = 1 },
            -- COLUMN 2: first the icon (`kind_icon`), then the kind name text (`kind`)
            { "kind_icon", "kind" },
          },
        },
      },

      -- Show documentation when selecting a completion item
      documentation = { auto_show = true, auto_show_delay_ms = 500 },

      -- Display a preview of the selected item on the current line
      ghost_text = { enabled = true },

      -- signature help (enabled here, unchanged)
      signature = { enabled = true },
    },

    -- Use a preset for snippets, check the snippets documentation for more information
    -- snippets = { preset = "default" | "luasnip" | "mini_snippets" },

    -- Experimental signature help support (unchanged - deactivated!)
    -- signature = { enabled = true },

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

    -- If you don’t want blink.cmp in certain filetypes, keep this:
    enabled = function()
      return not vim.tbl_contains({
        -- "lua",
        "markdown",
      }, vim.bo.filetype)
    end,

    -- Blink also powers cmdline if you like:
    cmdline = {
      enabled = true,
      completion = { ghost_text = { enabled = true } },
    },
  },
}
