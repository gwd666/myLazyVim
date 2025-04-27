local servers = {
  "awk-language-server",
  "bash-language-server",
  "black",
  "clang-format",
  "clangd",
  "codelldb",
  "cpptools",
  "elixir-ls",
  -- "flake8", -- tht's a linter and not a lsp
  -- "gofumpt", -- not a lsp
  -- "goimports", -- not a lsp
  "gopls",
  -- "jq", -- a formatter anf not a lsp
  "json-lsp",
  "julia-lsp",
  "lua-language-server",
  "markdown-toc", -- despite being a formatter it was possible to install it here?
  "markdownlint-cli2", -- despite being a formatter it was possible to install it here?
  "marksman", -- that is a markdown lsp
  "ocaml-lsp",
  "powershell-editor-services",
  "pyright",
  "python-lsp-server",
  "r-languageserver",
  "ruff",
  "rust-analyzer",
  "shfmt",
  "sqls",
  "stylua",
  "taplo", -- toml toolkit written in rust
  "zls@0.13.0",
}

return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    build = ":MasonUpdate",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "",
            package_pending = "",
            -- package_uninstalled = "",
            -- alternavive icons
            --       package_installed = "✓",
            --       package_pending = "➜",
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
