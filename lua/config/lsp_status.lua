local lsp_status = require("lsp-status")
local lspconfig = require("lspconfig")

require("lsp-status").register_progress()

-- -- Some arbitrary servers
-- lspconfig.clangd.setup({
--   handlers = lsp_status.extensions.clangd.setup(),
--   init_options = {
--     clangdFileStatus = true,
--   },
--   on_attach = lsp_status.on_attach,
--   capabilities = lsp_status.capabilities,
--   lsp_status.status(),
-- })
--
-- -- lspconfig.pyls_ms.setup({ -- pyls_ms is the MS fork of pyls but cannot be found by LspInstall?
-- --   handlers = lsp_status.extensions.pyls_ms.setup(),
-- --   settings = { python = { workspaceSymbols = { enabled = true } } },
-- --   on_attach = lsp_status.on_attach,
-- --   capabilities = lsp_status.capabilities,
-- -- })
--
-- lspconfig.pylsp.setup({
--   -- handlers = lsp_status.extensions.pylsp.setup(), -- this needs to have values available
--   settings = { python = { workspaceSymbols = { enabled = true } } },
--   on_attach = lsp_status.on_attach,
--   capabilities = lsp_status.capabilities,
--   lsp_status.status(),
-- })
--
-- -- lspconfig.ruff_lsp.setup({
-- --   -- handlers = lsp_status.extensions.ruff_lsp.setup(),
-- --   -- settings = { python = { workspaceSymbols = { enabled = true } } },
-- --   on_attach = lsp_status.on_attach,
-- --   capabilities = lsp_status.capabilities,
-- --   lsp_status.status(),
-- -- })
--
-- -- lspconfig.ghcide.setup({ -- this would be haskell I guess
-- --   on_attach = lsp_status.on_attach,
-- --   capabilities = lsp_status.capabilities,
-- -- })
--
-- lspconfig.rust_analyzer.setup({
--   on_attach = lsp_status.on_attach,
--   capabilities = lsp_status.capabilities,
--   lsp_status.status(),
-- })

lspconfig.lua_ls.setup({
  on_attach = lsp_status.on_attach,
  capabilities = lsp_status.capabilities,
  lsp_status.status(),
})

-- lspconfig.julials.setup({
--   on_attach = lsp_status.on_attach,
--   capabilities = lsp_status.capabilities,
--   lsp_status.status(),
-- })
--

-- Statusline
-- vim.cmd([[
--   function! LspStatus() abort
--     if luaeval('#vim.lsp.buf_get_clients() > 0')
--       return luaeval("require('lsp-status').status()")
--     endif
--     return ''
--   endfunction
-- ]])
