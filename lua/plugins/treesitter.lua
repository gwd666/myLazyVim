return {
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "go",
        "elixir",
        "html",
        "javascript",
        "json",
        "julia",
        "lua",
        "markdown",
        "markdown_inline",
        "ocaml",
        "python",
        "query",
        "r",
        "regex",
        "rust",
        "sql",
        -- "tsx",
        "typescript",
        "vim",
        "yaml",
        "zig",
      },
    },
  },
}
