-- fix for telescope window only immediately closing on Windows
-- when hitting <leader>gs to open git status
return {
  "nvim-telescope/telescope.nvim",
  opts = function(_, opts)
    local actions = require("telescope.actions")
    opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
      -- Fix for Windows git status
      mappings = {
        i = {
          ["<esc>"] = actions.close,
        },
      },
    })
    opts.pickers = vim.tbl_deep_extend("force", opts.pickers or {}, {
      git_status = {
        git_icons = {
          added = "+",
          changed = "~",
          copied = ">",
          deleted = "-",
          renamed = "➡",
          unmerged = "‡",
          untracked = "?",
        },
        -- Use Windows-compatible git command
        use_git_root = true,
      },
    })
    return opts
  end,
}
