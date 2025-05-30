return {
  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    enable = true,
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    sources = {
      -- Copilot source
      { name = "copilot", group_index = 2 },
      -- Other sources
      { name = "nvim_lsp", group_index = 2 },
      -- { name = "path", group_index = 2 },
      { name = "luasnip", group_index = 2 },
      -- R-nvim/cmp-R
      { name = "cmp_r", group_index = 2 },
    },
    -- local lspkind = require("lspkind")
    -- formatting = {
    --   format = require("lspkind").cmp_format({
    --     mode = "symbol", -- show only symbol annotations
    --     max_width = 50, -- prevent popup from showing more than 50 characters
    --     symbol_map = { Copilot = "" },
    --   }),
    -- },
    ---param opts cmp.ConfigSchema
    -- opts = function(_, opts)
    --   local has_words_before = function()
    --     unpack = unpack or table.unpack
    --     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    --     return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    --   end
    --
    --   local cmp = require("cmp")
    --   local luasnip = require("luasnip")
    --
    --   opts.mapping = vim.tbl_extend("force", opts.mapping, {
    --     ["<Tab>"] = cmp.mapping(function(fallback)
    --       --if cmp.visible() and has_words_before() then
    --       if cmp.visible() then
    --         cmp.select_next_item()
    --         -- cmp.select_next_item({ behavior = cmp.SelectionBehavior.Select })
    --         -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
    --         -- they way you will only jump inside the snippet region
    --       elseif luasnip.expand_or_jumpable() then
    --         luasnip.expand_or_jump()
    --       elseif has_words_before() then
    --         cmp.complete()
    --       else
    --         fallback()
    --       end
    --     end, { "i", "s" }),
    --     ["<S-Tab>"] = cmp.mapping(function(fallback)
    --       if cmp.visible() then
    --         cmp.select_prev_item()
    --       elseif luasnip.jumpable(-1) then
    --         luasnip.jump(-1)
    --       else
    --         fallback()
    --       end
    --     end, { "i", "s" }),
    --   })
    -- end,
  },
}
