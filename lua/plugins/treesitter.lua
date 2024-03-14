return {
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "html",
        "javascript",
        "json",
        "lua",
        -- "markdown",
        -- "markdown_inline",
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
