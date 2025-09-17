-- mason and mason-lspconfig released version 2.0.0
-- with some breaking changes, multiple methods have been changed
-- therefore (for now) a workaround is needed for Mason to still work in LazyVim
-- THIS WILL PIN the Version number, remove later, when no longer needed
return {
  --   { "mason-org/mason.nvim", version = "^1.11.0" },
  --   { "mason-org/mason-lspconfig.nvim", version = "^1.32.0" },
}

-- as of version 15.0.1 of LazyVim this workaround is no longer needed
-- just leaving it here as a template on how to fix a specific extension version via .lua file
