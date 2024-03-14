-- Make telescope config load automatically loaded on the VeryLazy event
local previewers = require("telescope.previewers")
local plenarypath = vim.fn.stdpath("data") .. "/lazy/plenary.nvim"
local project_actions = require("telescope._extensions.project.actions")
local harpoon = require("harpoon")

vim.opt.rtp:prepend(plenarypath)
local Job = require("plenary.job")

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}
  Threshold = 1550000
  filepath = vim.fn.expand(filepath)
  Job:new({
    command = "C:\\Program Files\\Git\\usr\\bin\\file", -- do a check on this Git/bin/file path in case you copy to other machine!
    args = { "--mime-type", "-b", filepath },
    on_exit = function(j)
      local mime_type = vim.split(j:result()[1], "/")[1]
      if mime_type == "text" then
        vim.loop.fs_stat(filepath, function(_, stat)
          if not stat then
            return
          end
          if stat.size > Threshold then
            vim.schedule(function()
              vim.api.nvim_buf_set_lines(
                bufnr,
                0,
                -1,
                false,
                { " FILE > Threshold: " .. Threshold / 1000 .. " KB ... " }
              )
            end)
            return
          else
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
          end
        end)
      else -- maybe we want to write something to the buffer here
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { " ... BINARY ... " })
        end)
      end
    end,
  }):sync()
end
-- call via:
-- :lua require"telescope-config".project_files()

-- example keymap:
-- vim.api.nvim_set_keymap("n", "<Leader><Space>", "<CMD>lua require'telescope-config'.project_files()<CR>", {noremap = true, silent = true})
require("telescope").setup({ -- change some telescope options and a keymap to browse plugin files
  -- change some telescope options
  defaults = {
    buffer_previewer_maker = new_maker, -- from funcs above
    layout_config = {
      vertical = { width = 0.6 },
      horizontal = { height = 0.6 },
      prompt_position = "top", -- or "bottom"
    },
    sorting_strategy = "ascending",
    winblend = 5,
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim", -- add this to trim indentation at beginning of result window
    },
    mappings = {
      n = {
        -- add mapping to toggle preview
        ["<M-p>"] = require("telescope.actions.layout").toggle_preview,
        ["<M-h>"] = "which_key",
        ["cd"] = function(prompt_bufnr)
          local selection = require("telescope.actions.state").get_selected_entry()
          local dir = vim.fn.fnamemodify(selection.path, ":p:h")
          require("telescope.actions").close(prompt_bufnr)
          -- Depending on what you want put `cd`, `lcd`, `tcd`
          vim.cmd(string.format("silent lcd %s", dir))
        end,
      },
      i = {
        -- map actions,which-key to <C-h> (defatult: <C-/>)
        -- actions.which-key shows mappings for yr pickers
        ["<M-p>"] = require("telescope.actions.layout").toggle_preview,
        ["<M-h>"] = "which_key",
      },
    },
  },
  pickers = {
    find_files = {
      mappings = {
        n = { -- add change dir functionality to find_file picker
          ["cd"] = function(prompt_bufnr)
            local selection = require("telescope.actions.state").get_selected_entry()
            local dir = vim.fn.fnamemodify(selection.path, ":p:h")
            require("telescope.actions").close(prompt_bufnr)
            -- deepending on yr pref put 'cd', 'lcd', 'tcs'
            vim.cmd(string.format("silent lcd %s", dir))
          end,
        },
      },
      layout_strategy = "horizontal",
      layout_config = {
        prompt_position = "top",
        preview_width = 0.6,
      },
      winblend = 5,
    },
    help_tags = {
      theme = "dropdown",
      winblend = 15,
      sorting_strategy = "ascending",
    },
    live_grep = {
      layout_strategy = "horizontal",
      sorting_strategy = "descending",
      layout_config = {
        prompt_position = "bottom",
        preview_width = 0.6,
      },
      winblend = 10,
    },
  },
  extensions = {
    project = {
      base_dirs = {
        "~/OneDrive/Documents/DEV",
        "~/devel@E",
        -- { "~/dev/DEV@OneDrive", max_depth = 3 },
        -- { path = "~/dev", max_depth = 2 },
        -- { path = "~/dev/DEV@OneDrive/Sky_git/" },
        -- { path = "~/dev", max_depth = 4 },
      },
      hidden_files = true, -- default: false
      theme = "dropdown",
      order_by = "asc",
      search_by = "title",
      sync_with_nvim_tree = true, -- default false
      -- default for on_project_selected = find project files
      on_project_selected = function(prompt_bufnr)
        -- Do anything you want in here. For example:
        project_actions.change_working_directory(prompt_bufnr, false)
        require("harpoon.ui"):toggle_quick_menu(harpoon:list())
      end,
    },
  },
  -- configuring prieviewer ... nope not yet working?
  -- previewers = {
  --   vim_buffer_cat = {
  --     -- configure Telescope vim_buffer_ previewer
  --     vim.api.nvim_create_autocmd("User", {
  --       pattern = "TelescopePreviewerLoaded",
  --       callback = function(args)
  --         if args.data.filetype ~= "help" then
  --           vim.bo.number = true
  --         elseif args.data.bufname:match("*.csv") then
  --           vim.bo.wrap = false
  --         end
  --       end,
  --     }),
  --   },
  -- },
  keys = {
    -- add a keymap to browse plugin files
    -- stylua: ignore
    {
      "<leader>fp",
      function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
      desc = "Find Plugin File",
    },
  },
})
