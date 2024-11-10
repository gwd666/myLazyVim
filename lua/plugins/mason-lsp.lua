local servers = {
  "awk-language-server",
  "bash-language-server",
  "black",
  "clang-format",
  "clangd",
  "codelldb",
  "cpptools",
  "elixir-ls",
  "flake8",
  "gofumpt",
  "goimports",
  "gopls",
  "jq",
  "json-lsp",
  "julia-lsp",
  "lua-language-server",
  "markdown-toc",
  "markdownlint-cli2",
  "marksman",
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
  "taplo",
  "zls",
}

return {
  require("mason").setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  }),
  require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true,
  }),
}
