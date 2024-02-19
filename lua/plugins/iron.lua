return {
  {
    "hkupty/iron.nvim",
    -- note that `init` will disable lazy-loading!
    init = function()
      local iron = require("iron.core")
      local view = require("iron.view")
      iron.setup({
        -- add the other options if you want
        config = {
          -- Whether a repl should be discarded or not
          scratch_repl = true,
          -- Your repl definitions come here
          repl_definition = {
            sh = {
              -- Can be a table or a function that
              -- returns a table (see below)
              command = { "bash" },
            },
            julia = {
              command = { "julia" },
            },
            python = {
              command = { "ipython" },
            },
            r = {
              command = { "radian" },
            },
          },
          -- How the repl window will be displayed
          -- See below for more information
          repl_open_cmd = "vertical botright 80 split",
        },
        -- Iron doesn't set keymaps by default anymore.
        -- You can set them here or manually add keymaps to the functions in iron.core
        keymaps = { -- keymaps are managed in keymaps.lua
          send_motion = "<space>kc",
          visual_send = "<space>rc",
          send_file = "<space>ra", -- rf is reserved for repl start so using a for all
          send_line = "<space>rl",
          send_until_cursor = "<space>ru",
          send_mark = "<space>rm",
          mark_motion = "<space>mc",
          mark_visual = "<space>mc",
          remove_mark = "<space>md",
          cr = "<space>r<cr>",
          interrupt = "<space>r<space>",
          exit = "<space>rq",
          clear = "<space>rx",
        },
        -- If the highlight is on, you can change how it looks
        -- For the available options, check nvim_set_hl
        highlight = {
          italic = true,
        },
        ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
      })
    end,
  },
}
