return {
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
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
        "powershell",
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
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "r", "python", "rnoweb", "yaml" },
        highlight = {
          enable = true,
        },
      })
    end,
  },
}
