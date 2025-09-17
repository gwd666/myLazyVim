-- basic telescope configuration
local conf = require("telescope.config").values

local harpoon = require("harpoon")
harpoon:setup({})

local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end
  -- print the file paths to the console
  -- print(vim.inspect(file_paths)) -- this gets printed as "keymaps.lua" ie the file in harpoon list
  require("telescope.pickers")
    .new({ layout_config = { preview_width = 0.55 } }, {
      prompt_title = "My harpoon marks",
      finder = require("telescope.finders").new_table({
        results = file_paths,
      }),
      previewer = conf.file_previewer({}),
      sorter = conf.generic_sorter({}),
    })
    :find()
end

vim.keymap.set("n", "<leader>fH", function()
  -- vim.cmd(":Telescope harpoon marks<CR>") -- this also works
  toggle_telescope(harpoon:list())
end, { noremap = true, desc = "Toggle Telescope harpoon list" })

-- example code or options to make harpoon "cleaner"
vim.cmd("highlight! HarpoonInactive guibg=NONE guifg=#63698c")
vim.cmd("highlight! HarpoonActive guibg=NONE guifg=white")
vim.cmd("highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7")
vim.cmd("highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7")
vim.cmd("highlight! TabLineFill guibg=NONE guifg=white")

-- using extend functionality to add keymaps to open files in splits or tabs
harpoon:extend({
  UI_CREATE = function(cx)
    vim.keymap.set("n", "<C-v>", function() -- open file in vertical split
      harpoon.ui:select_menu_item({ vsplit = true })
    end, { buffer = cx.bufnr, desc = "Open file in vertical split}" })

    vim.keymap.set("n", "<C-x>", function() -- open file in horizontal split
      harpoon.ui:select_menu_item({ split = true })
    end, { buffer = cx.bufnr, desc = "Open file in horizontal split" })

    vim.keymap.set("n", "<C-T>", function() -- open file in new tab
      harpoon.ui:select_menu_item({ tabedit = true })
    end, { buffer = cx.bufnr, desc = "Open file in new tab" })
  end,
})

-- vim.keymap.del("n", "<C-d>") -- remove the harpoon C-d in Normal mode which otherwose deletes marks mapping

-- trying to modify the default keymaps along these lines
-- local actions = require("telescope.actions")
-- local state = require("telescope.actions.state")
--
-- -- Custom mapping function
-- local function custom_keymap(prompt_bufnr, map)
--   local picker = state.get_current_picker(prompt_bufnr)
--   local picker_title = picker.prompt_title
--
--   -- check if the current picker is Harpoon2's picker
--   if picker_title == "harpoon marks" then
--     -- map <c-d> in normal mode to scroll prewview window down
--     map("n", "<C-d>", function(prompt_bufnr)
--       require("telescope.state").get_status(prompt_bufnr).picker.layout_config.scroll_speed = nil
--       return require("telescope.actions").preview_scrolling_down(prompt_bufnr)
--     end)
--   end
--
--   return true
-- end
