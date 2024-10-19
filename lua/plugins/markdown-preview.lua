-- add markdown previewer
return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" },
    -- build = "cd app && yarn install",
    -- build = ":call mkdp#util#install()",
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    init = function()
      vim.cmd([[
        let g:mkdp_echo_preview_url = 1
        let g:mkdp_auto_close = 0
        let g:mkdp_combine_preview = 1
        ]])
    end,
  },
}
