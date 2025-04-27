return {
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "elixir",
        "go",
        "html",
        "javascript",
        "json",
        "julia",
        "llvm",
        "lua",
        "latex",
        -- "markdown", -- this is anyhow part of nvim-treesitter
        -- "markdown_inline", -- this is anyhow part of nvim-treesitter
        "powershell",
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
