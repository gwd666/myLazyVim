local iron = require("iron.core")
local view = require("iron.view")

return { -- needed to avoid erroring b/c of bool not table
  iron.setup({
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
        cmd = {
          command = { "cmd" },
        },
        -- julia = {
        -- command = { "C:\\Users\\gwd\\.julia\\juliaup\\julia-1.9.0+0.x64.w64.mingw32\\bin\\julia.exe" },
        -- command = { "julia" },
        -- },
      },
      -- How the repl window will be displayed
      -- See below after line 45 for more information
      -- repl_open_cmd = require('iron.view').bottom(40),
      repl_open_cmd = view.split.vertical.botright(0.4575),
    },
    -- Iron doesn't set keymaps by default anymore.
    -- You can set them here or manually add keymaps to the functions in iron.core
    keymaps = {
      send_motion = "<space>sm",
      visual_send = "<space>sv",
      send_file = "<space>sf",
      send_line = "<space>sl",
      send_mark = "<space>ms",
      mark_motion = "<space>mc",
      mark_visual = "<space>mv",
      remove_mark = "<space>md",
      cr = "<space>s<cr>",
      interrupt = "<space>s<space>",
      exit = "<space>sq",
      clear = "<space>cl",
    },
    -- If the highlight is on, you can change how it looks
    -- For the available options, check nvim_set_hl
    highlight = {
      italic = true,
    },
    ignore_blank_lines = true, -- ignore blank lines when sending visual select lines

    -- ==============================================================================
    -- define REPL positions and sizes
    -- Vertical 50 columns split
    -- Split has a metatable that allows you to set up the arguments in a "fluent" API
    -- you can write as you would write a vim command.
    -- It accepts:
    --   - vertical
    --   - leftabove/aboveleft
    --   - rightbelow/belowright
    --   - topleft
    --   - botright
    -- They'll return a metatable that allows you to set up the next argument
    -- or call it with a size parameter
    -- repl_open_cmd = view.split.vertical.botright(50)

    -- If the supplied number is a fraction between 1 and 0,
    -- it will be used as a proportion
    -- repl_open_cmd = view.split.vertical.botright(0.61903398875)
  }),
}
