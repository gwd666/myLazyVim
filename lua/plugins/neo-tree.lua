-- Plugin: nvim-neo-tree/neo-tree.nvim
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  requires = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    {
      "s1n7ax/nvim-window-picker",
      version = "2.*",
      config = function()
        require("window-picker").setup({
          filter_rules = {
            include_current_win = false,
            autoselect_one = true,
            -- filter using buffer options
            bo = { -- buffer-options ... bo
              -- if the file type is one of following, the window will be ignored
              filetype = { "neo-tree", "neo-tree-popup", "notify" },
              -- if the buffer type is one of following, the window will be ignored
              buftype = { "terminal", "quickfix" },
            },
          },
        })
      end,
    },
  },

  config = function()
    -- If you want icons for diagnostic errors, you'll need to define them somewhere:
    vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
    vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
    vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })
    -- define this local getTelesocpeOpts func to use in 'commands' config below
    local function getTelescopeOpts(state, path)
      return {
        cwd = path,
        search_dirs = { path },
        attach_mappings = function(prompt_bufnr, map)
          local actions = require("telescope.actions")
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local action_state = require("telescope.actions.state")
            local selection = action_state.get_selected_entry()
            local filename = selection.filename
            if filename == nil then
              filename = selection[1]
            end
            -- any way to open the file without triggering auto-close event of neo-tree?
            require("neo-tree.sources.filesystem").navigate(state, state.path, filename)
          end)
          return true
        end,
      }
    end

    require("neo-tree").setup({
      -- opts = {
      close_if_last_window = false, -- close Neo-tree if it's the last window left
      -- },
      update_focused_file = { enable = true },
      event_handlers = {
        -- event handlers to hide cursor in neootree window - only see the line hgighlight
        {
          event = "neo_tree_buffer_enter",
          handler = function()
            vim.cmd("highlight! Cursor blend=100")
          end,
        },
        {
          event = "neo_tree_buffer_leave",
          handler = function()
            vim.cmd("highlight! Cursor blend=0")
          end,
          -- handler = function() -- highlighted cursor
          --   vim.cmd("highlight! Cursor guibg=#5f87af blend=0")
          -- end,
        },
        -- handler to equalize window sizes on neotree open/close
        -- { -- comment/uncomment to enable/disable pasted commented out
        --   event = "neo_tree_window_before_open",
        --   handler = function(args)
        --     print("neo_tree_window_before_open", vim.inspect(args))
        --   end,
        -- },
        { -- hanbler to follow opened files in neotree window
          event = "neo_tree_window_after_open",
          handler = function(args)
            if args.position == "left" or args.position == "right" then
              vim.cmd("wincmd=")
            end
          end,
        },
        -- { -- comment/uncomment to enable/disable pasted commented out
        --   event = "neo_tree_window_before_close",
        --   handler = function(args)
        --     print("neo_tree_window_before_close", vim.inspect(args))
        --   end,
        -- },
        {
          event = "neo_tree_window_after_close",
          handler = function(args)
            if args.position == "left" or args.position == "right" then
              vim.cmd("wincmd=")
            end
          end,
        },
      }, -- end of event_handlers
      source_selector = {
        -- you can enable a clickable source selector in winbar or statusline
        winbar = true, -- Show a winbar in the neotree window: the bar showing Files/Buffers/Git Tabs
        statusline = false, -- this means when I move to neotree statusbar gets hidden
        git_status = true, -- Show git status with icons not sure what this changes in NTree
      }, -- end of source_selector
      -- This will go to folder of current file in neotree window
      filesystem = {
        bind_to_cwd = true, -- default is: false
        follow_current_file = { enabled = true }, -- true is anyhow default
        window = {
          mappings = {
            ["Tf"] = "telescope_find",
            ["Tg"] = "telescope_grep",
            ["X"] = "system_open", -- mapping for system_open command below
          },
        },
        components = {
          harpoon_index = function(config, node, _) -- this will add a harpoon index id to the node if assigned
            local harpoon_list = require("harpoon"):list()
            local path = node:get_id()
            -- version 1:
            local harpoon_key = vim.uv.cwd()
            for i, item in ipairs(harpoon_list.items) do
              local value = item.value
              if string.sub(item.value, 1, 1) ~= "/" then
                value = harpoon_key .. "/" .. item.value
              end
              if value == path then
                vim.print(path)
                return {
                  text = string.format(" ⥤  %d", i), -- <-- Add your favorite harpoon like arrow here
                  highlight = config.highlight or "NeoTreeDirectoryIcon",
                }
              end
            end
            return {} -- end of version 1 for harpoon
            -- version 2: alternative for harpoon if aobove vers.1 fails
            -- local Marked = require("harpoon.mark")
            -- local path = node:get_id()
            -- local success, index = pcall(Marked.get_index_of, path)
            -- if success and index and index > 0 then
            --   return {
            --     text = string.format(" ⥤  %d", index), -- <-- Add your favorite harpoon like arrow here
            --     highlight = config.highlight or "NeoTreeDirectoryIcon",
            --   }
            -- else
            --   return {
            --     text = "  ",
            --   }
            -- end -- end of version 2
          end,
        }, -- end of components
        renderers = { -- added for harpoon_index
          file = {
            { "icon" },
            { "name", use_git_status_colors = true }, -- file name
            { "harpoon_index" }, --> This is what actually adds the component in where you want it
            { "diagnostics" },
            { "git_status", highlight = "NeoTreeDimText" },
          },
        }, -- end of renderers
      }, -- end of filesystem
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "󰜌",
        provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
          if node.type == "file" or node.type == "terminal" then
            local success, web_devicons = pcall(require, "nvim-web-devicons")
            local name = node.type == "terminal" and "terminal" or node.name
            if success then
              local devicon, hl = web_devicons.get_icon(name)
              icon.text = devicon or icon.text
              icon.highlight = hl or icon.highlight
            end
          end
        end,
        -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
        -- then these will never be used.
        default = "*",
        highlight = "NeoTreeFileIcon",
      }, -- end of icon
      -- a list of functions each a global custom commandable action
      commands = {
        system_open = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          -- Linux: open file in default app
          vim.fn.jobstart({ "xdg-open", path }, { detach = true })
          -- for windows see: https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes#open-with-system-viewer
        end,
        telescope_find = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          require("telescope.builtin").find_files(getTelescopeOpts(state, path))
        end,
        telescope_grep = function(state)
          local node = state.tree:get_node()
          local path = node:get_id()
          require("telescope.builtin").live_grep(getTelescopeOpts(state, path))
        end,
      }, -- end of commands
      window = {
        position = "right", -- open to the right, default is left as in VSC ;-)
        mappings = { -- keymaps for moving between the Files|Buffers|Git tabs
          ["e"] = function()
            -- DO NOT REWRITE THOSE exec2 calls -> they will break if you do so!
            vim.api.nvim_exec2("Neotree focus filesystem right", { output = true })
          end,
          ["b"] = function()
            -- DO NOT REWRITE THOSE exec2 calls -> they will break if you do so!
            vim.api.nvim_exec2("Neotree focus buffers right", { output = true })
          end,
          ["g"] = function()
            -- DO NOT REWRITE THOSE exec2 calls -> they will break if you do so!
            vim.api.nvim_exec2("Neotree focus git_status right", { output = true })
          end,
        },
      }, -- end of window
    })
  end,
}
