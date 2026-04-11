return {
  { "giuxtaposition/blink-cmp-copilot", enabled = false },
  {
    "fang2hou/blink-copilot",
    optional = true,
    opts = {
      max_completions = 4,
      max_attempts = 3,
    },
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "Exafunction/codeium.nvim",
      "fang2hou/blink-copilot",
      "moyiz/blink-emoji.nvim",
    },
    opts = function(_, opts)
      opts.keymap = opts.keymap or {}
      opts.keymap.preset = "super-tab"
      opts.keymap["<C-k>"] = false
      opts.keymap["<C-j>"] = false

      opts.sources = opts.sources or {}
      opts.sources.default = opts.sources.default or { "lsp", "path", "snippets", "buffer" }
      if not vim.tbl_contains(opts.sources.default, "emoji") then
        table.insert(opts.sources.default, 4, "emoji")
      end

      opts.sources.providers = opts.sources.providers or {}
      opts.sources.providers.emoji = vim.tbl_deep_extend("force", opts.sources.providers.emoji or {}, {
        module = "blink-emoji",
        name = "emoji",
        score_offset = 15,
        opts = { insert = true },
        should_show_items = function()
          return vim.tbl_contains({ "gitcommit", "markdown" }, vim.bo.filetype)
        end,
      })

      if opts.sources.providers.copilot then
        opts.sources.providers.copilot = vim.tbl_deep_extend("force", opts.sources.providers.copilot, {
          score_offset = 500,
          transform_items = function(_, items)
            for _, item in ipairs(items) do
              item.kind_icon = ""
              item.kind_name = "Copilot"
            end
            return items
          end,
          max_items = 3,
        })
      end

      if opts.sources.providers.codeium then
        opts.sources.providers.codeium = vim.tbl_deep_extend("force", opts.sources.providers.codeium, {
          score_offset = 100,
          transform_items = function(_, items)
            for _, item in ipairs(items) do
              item.kind_icon = ""
              item.kind_name = "Codeium"
            end
            return items
          end,
          max_items = 4,
        })
      end

      opts.completion = opts.completion or {}
      opts.completion.keyword = { range = "full" }
      opts.completion.accept = vim.tbl_deep_extend("force", opts.completion.accept or {}, {
        auto_brackets = { enabled = false },
      })
      opts.completion.list = vim.tbl_deep_extend("force", opts.completion.list or {}, {
        selection = {
          preselect = function()
            return vim.bo.filetype ~= "markdown"
          end,
        },
      })
      opts.completion.menu = vim.tbl_deep_extend("force", opts.completion.menu or {}, {
        auto_show = false,
        draw = {
          columns = {
            { "label", "label_description", gap = 1 },
            { "kind_icon", "kind" },
          },
        },
      })
      opts.completion.documentation = vim.tbl_deep_extend("force", opts.completion.documentation or {}, {
        auto_show = true,
        auto_show_delay_ms = 500,
      })
      opts.completion.ghost_text = vim.tbl_deep_extend("force", opts.completion.ghost_text or {}, {
        enabled = true,
      })

      opts.signature = vim.tbl_deep_extend("force", opts.signature or {}, {
        enabled = true,
      })

      opts.cmdline = vim.tbl_deep_extend("force", opts.cmdline or {}, {
        enabled = true,
        completion = { ghost_text = { enabled = true } },
      })
    end,
    enabled = function()
      return not vim.tbl_contains({ "markdown" }, vim.bo.filetype)
    end,
  },
}
