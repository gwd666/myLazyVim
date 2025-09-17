-- ~/.config/nvim/lua/plugins/blink.lua
-- (This file is loaded by LazyVim. We override "saghen/blink.cmp" here.)

return {
  -- Disable the official “blink-cmp-copilot” plugin (we’ll use “blink.cmp” instead)
  { "giuxtaposition/blink-cmp-copilot", enabled = false },

  {
    "saghen/blink.cmp",
    dependencies = {
      "Exafunction/codeium.nvim",
      "fang2hou/blink-copilot",
      "moyiz/blink-emoji.nvim",
    },

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
        accept = false,
        next = "<M-]>",
        prev = "<M-[>",
      },
    },

    -- ────────────────────────────────────────────────────────────────────────────
    -- Here is our override for all of blink.cmp’s options.  Notice the structure:
    --   opts = {
    --     sources = { default = { … }, providers = { … } },
    --     completion = { keyword = {…}, accept = {…}, list = {…}, menu = {…}, documentation = {…}, ghost_text = {…} },
    --     signature = { … },
    --   }
    --
    -- If any of these nested tables are indented incorrectly, or if you put
    -- `draw.columns` in the wrong “menu” table, Blink will ignore it and fall
    -- back to its defaults.
    -- ────────────────────────────────────────────────────────────────────────────
    opts = {
      keymap = {
        -- 'super-tab' for mappings similar to vscode (i.e. TAB to accept)
        preset = "super-tab",
        -- 'enter' for enter to accept completions
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- preset = "enter",
        -- 'none' for no mappings or to disable the default mappings
        -- All presets have the following mappings in common:
        -- <C-space> ... open menu or open docs if already open
        -- <C-n>/<C-p> or <up>/<down> ... select next/previous item
        -- <C-e> ... hide menu opposite of C-space
        -- <C-k> ... toggle signature help (if signature.enabled = true)
        -- disable a keymap from the preset
        ["<C-k>"] = false, -- or {}
        ["C-o"] = { "show_signature", "hide_signature", "fallback" },
      },
      sources = {
        default = { "lsp", "path", "snippets", "emoji", "buffer", "codeium", "copilot" },
        providers = {
          ------------------------------------------------------------------------------------------------
          -- 1) Emoji provider (unchanged)                                                                --
          ------------------------------------------------------------------------------------------------
          emoji = {
            module = "blink-emoji",
            name = "emoji",
            score_offset = 15,
            opts = { insert = true },
            should_show_items = function()
              return vim.tbl_contains({ "gitcommit", "markdown" }, vim.o.filetype)
            end,
          },

          ------------------------------------------------------------------------------------------------
          -- 2) Copilot provider                                                                             --
          --    Every item that Copilot hands back will be given:                                          --
          --      kind_icon = ""   (the Copilot logo)                                                      --
          --      kind_name = "Copilot"  (so the rightmost column literally says “Copilot”)                  --
          ------------------------------------------------------------------------------------------------
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 500,
            async = true,
            opts = {
              max_completions = 4,
              max_attempts = 3,
            },

            transform_items = function(_, items)
              local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
              local kind_idx = #CompletionItemKind + 1
              CompletionItemKind[kind_idx] = "Copilot"

              for _, item in ipairs(items) do
                item.kind = kind_idx
                -- Force every Copilot item to have this icon and this “kind” text:
                item.kind_icon = "" -- you can pick a different icon if you prefer
                item.kind_name = "Copilot"
                -- (Optionally, you could do `item.kind = kind_idx` instead of setting kind_name,
                --  but in newer Blink versions setting item.kind_name is sufficient.)
              end

              return items
            end,
          },

          ------------------------------------------------------------------------------------------------
          -- 3) Codeium provider                                                                              --
          --    Every item from Codeium will have:                                                          --
          --      kind_icon = ""    (the Codeium logo)                                                       --
          --      kind_name = "Codeium"   (so the rightmost column literally says “Codeium”)                   --
          ------------------------------------------------------------------------------------------------
          codeium = {
            name = "codeium",
            -- If you want to use the “codeium.blink” compatibility layer, uncomment the next line:
            -- module       = "codeium.blink",
            score_offset = 100,
            async = true,

            transform_items = function(_, items)
              -- ① Debug‐print so you see in :messages when Codeium runs:
              -- comment/uncomment - bsaed on require
              -- vim.schedule(function()
              --   vim.notify(
              --     "▶▶▶ Running Codeium transform_items (got " .. #items .. " items)",
              --     vim.log.levels.INFO
              --   )
              -- end)
              local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
              -- 1) Create a fresh slot at the end of the enum, called “Codeium”:
              local kind_idx = #CompletionItemKind + 1
              CompletionItemKind[kind_idx] = "Codeium"

              for _, item in ipairs(items) do
                -- 2) Tell cmp “this item’s kind is that new index”:
                item.kind = kind_idx
                item.kind_icon = "" -- you can choose any icon you like
                item.kind_name = "Codeium"
              end

              return items
            end,
          },
          ------------------------------------------------------------------------------------------------
          -- 4) (If you add any other providers, they go here.)                                             --
          ------------------------------------------------------------------------------------------------
        },
      },

      ----------------------------------------------------------------------------------------------------
      -- 5) Here is the “completion” section.  Make sure `menu.draw.columns` is exactly under `menu`.    --
      ----------------------------------------------------------------------------------------------------
      completion = {
        -- “prefix” vs “full” fuzziness, etc.
        keyword = { range = "full" },
        accept = { auto_brackets = { enabled = false } },

        -- When you scroll through the menu, we preselect (unless you’re in markdown):
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

        -- Show the little documentation box when you navigate items:
        documentation = { auto_show = true, auto_show_delay_ms = 500 },

        -- Show “ghost text” of the completion inline as you scroll:
        ghost_text = { enabled = true },
      },

      -- ────────────────────────────────────────────────────────────────────────────
      -- 6) Signature help (unchanged)                                               --
      -- ────────────────────────────────────────────────────────────────────────────
      signature = { enabled = true }, -- needs to be true in order to use C-k to toggle signature help
    },

    -- If you don’t want blink.cmp in certain filetypes, keep this:
    enabled = function()
      return not vim.tbl_contains({
        --"lua",
        "markdown",
      }, vim.bo.filetype)
    end,

    -- Blink also powers cmdline if you like:
    cmdline = {
      enabled = true,
      completion = { ghost_tex = { enabled = true } },
    },
  },
}
