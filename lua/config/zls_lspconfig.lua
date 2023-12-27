-- taken from: https://github.com/wnz27/zls-learn?tab=readme-ov-file#nvim-lspconfig
local lspconfig = require("lspconfig")

local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:loa.vim.lsp.omnifunc")
  require("completion").on_attach()
end

local servers = { "zls" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
  })
end
