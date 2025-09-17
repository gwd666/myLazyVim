local servers = {
  "awk-language-server",
  -- "awk_ls",
  "bash-language-server",
  -- "bashls",
  -- "black",
  -- "clang-format",
  -- "clangd",
  -- "codelldb",
  -- "cpptools",
  -- "elixir-ls",
  "elixirls",
  -- "flake8", -- tht's a linter and not a lsp
  -- "gofumpt", -- not a lsp
  -- "goimports", -- not a lsp
  "gopls",
  -- "jq", -- a formatter anf not a lsp
  -- "json-lsp",
  "jsonls",
  -- "julia-lsp",
  "julials",
  -- "lua-language-server",
  "lua_ls",
  -- "markdown-toc", -- despite being a formatter it was possible to install it here?
  -- "markdownlint-cli2", -- despite being a formatter it was possible to install it here?
  -- "marksman", -- that is a markdown lsp
  -- "ocaml-lsp",
  "ocamllsp",
  -- "powershell-editor-services",
  "powershell_es",
  "pyright",
  -- "python-lsp-server",
  -- "r-languageserver",
  "r_language_server",
  -- "ruff",
  -- "rust-analyzer",
  "rust_analyzer",
  -- "shfmt",
  "sqls",
  -- "stylua",
  -- "taplo", -- toml toolkit written in rust
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
