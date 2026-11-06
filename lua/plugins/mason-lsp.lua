local servers = {
  "awk_ls",
  "bashls",
  "clangd",
  -- "codelldb", -- that's a DAP and not an LSP
  "elixirls",
  "gopls",
  "jsonls",
  "lua_ls",
  -- "markdownlint-cli2", -- despite being a formatter it was possible to install it here?
  "marksman", -- this is a markdown lsp
  "powershell_es",
  "pyright",
  "pylsp",
  -- ocamllsp is managed outside Mason (see lsp.lua).
  "r_language_server",
  "ruff",
  "rust_analyzer",
  "sqls",
  "taplo", -- toml toolkit written in rust
  "zls",
}

return {
  {
    "mason-org/mason.nvim",
    -- version = "1.11.*",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    build = ":MasonUpdate",
    opts = {
      ensure_installed = { "stylua" },
      ui = {
        icons = {
          package_installed = "",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = servers },
  },
}
