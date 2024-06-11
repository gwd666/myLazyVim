-- trying to remap lsp signature_help from C-k to C-o
return {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "<C-k>", mode = "i", false }
    keys[#keys + 1] =
      { "<C-o>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "SignatureHelp" }
    --  tyr to fix ""multiple different client offset_encodings detected" warning
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    require("lspconfig").clangd.setup({
      on_attach = on_attach,
      capabilities = cmp_nvim_lsp.default_capabilities(),
      cmd = {
        "clangd",
        "--offset-encoding=utf-16",
      },
    })

    vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]])
    vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]])

    local border = {
      -- { "🭽", "FloatBorder" },
      { "●", "FloatBorder" },
      { "▔", "FloatBorder" },
      -- { "🭾", "FloatBorder" },
      { "●", "FloatBorder" },
      { "▕", "FloatBorder" },
      -- { "🭿", "FloatBorder" },
      { "●", "FloatBorder" },
      { "▁", "FloatBorder" },
      -- { "🭼", "FloatBorder" },
      { "●", "FloatBorder" },
      { "▏", "FloatBorder" },
    }

    -- LSP settings (for overriding per client)
    local handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
      ["textDocmumen/functionInfo"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
    }

    -- Do not forget to use the on_attach function
    require("lspconfig").zls.setup({
      handlers = handlers,
      cmd = { "zls" },
      filetypes = { "zig", "zlr" },
    }) -- this put HERE - made 'zls' workk!

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
