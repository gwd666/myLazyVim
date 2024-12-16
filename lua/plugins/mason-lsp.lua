local servers = {
  -- "black",
  "clang-format",
  "clangd",
  "codelldb", -- DAP
  "cpptools", -- DAP (C/C++)
  "elixir-ls", -- DAP (Elixir)
  -- "flake8",
  -- "gofumpt",
  -- "goimports",
  "gopls",
  "jq", -- CLI json processor
  "json-lsp",
  "julia-lsp",
  "lua-language-server",
  "markdown-toc",
  "markdownlint-cli2", -- markdown linter
  "marksman", -- markdown previewer
  "ocaml-lsp",
  "powershell-editor-services",
  "pyright",
  "python-lsp-server",
  "r-languageserver",
  "ruff", -- pyhont linter written in rust
  "rust-analyzer",
  -- "shfmt", -- shell formatter (sh/bash/mksh)
  "sqls", -- Sql Language Server
  "stylua",
  "taplo", -- toml formatter written in rust
  "zls",
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
