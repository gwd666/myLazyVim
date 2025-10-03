local servers = {
  "awk_ls",
  "bashls",
  "clangd",
  -- "codelldb", -- that's a DAP and not an LSP
  "elixirls",
  "gopls",
  "jsonls",
  "julials",
  "lua_ls",
  -- "markdownlint-cli2", -- despite being a formatter it was possible to install it here?
  "marksman", -- this is a markdown lsp
  "ocamllsp",
  "powershell_es",
  "pyright",
  "pylsp",
  "r_language_server",
  "ruff",
  "rust_analyzer",
  "sqls",
  "stylua",
  "taplo", -- toml toolkit written in rust
  "zls",
}

return {
  {
    "mason-org/mason.nvim",
    -- version = "1.11.*",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    build = ":MasonUpdate",
    dependencies = {
      { "mason-org/mason-lspconfig.nvim" },
    },
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "",
            -- package_pending = "",
            -- package_uninstalled = "",
            -- alternavive icons
            --       package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
      -- require("mason-lspconfig").setup()
      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_installation = true,
      })
    end,
  },
}
