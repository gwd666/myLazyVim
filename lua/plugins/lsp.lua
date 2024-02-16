-- trying to remap lsp signature_help from C-k to C-o
return {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "<C-k>", mode = "i", false }
    keys[#keys + 1] =
      { "<C-o>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "SignatureHelp" }

    -- this commented out code below - breaks command completion in vim COMMAND mode/prompt
    -- '/' cmdline setup
    -- local cmp = require("cmp")
    -- cmp.setup.cmdline("/", {
    --   mapping = cmp.mapping.preset.cmdline(),
    --   sources = {
    --     { name = "buffer" },
    --   },
    -- })
    --
    -- -- ':' cmdline setup
    -- cmp.setup.cmdline(":", {
    --   mapping = cmp.mapping.preset.cmdline(),
    --   sources = cmp.config.sources({
    --     { name = "path" },
    --   }, {
    --     {
    --       name = "cmdline",
    --       option = {
    --         ignore_cmds = { "Man", "!" },
    --       },
    --     },
    --   }),
    -- })
  end,
}
