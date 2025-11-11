local servers = {
  -- "bash-language-server",
  "bashls",
  "clangd",
  -- "codelldb", -- that is a DAP and not a LSP
  "copilot",
  "gopls",
  "jsonls",
  -- "julials",
  "lua_ls",
  "marksman", -- that is a markdown lsp
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
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    build = ":MasonUpdate",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
            -- alternavive icons
            --       package_installed = "✓",
            -- package_pending = "➜",
            -- package_uninstalled = "✗",
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
