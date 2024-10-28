local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

-- two additional requires for replacing defatult actons
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

-- our picker function: colors
local colors = function(opts)
  opts = opts or {}
  pickers
    .new(opts, {
      prompt_title = "colors",
      finder = finders.new_table({
        results = { "red", "green", "blue" },
      }),
      sorter = conf.generic_sorter(opts),
    })
    :find()
end

-- to execute the function
-- colors()
colors(require("telescope.themes").get_dropdown({}))

-- you can run this file with `:luafile %`
-- which will open up a picker with the colors red, green, and blue

attach_mappings = function(prompt_bufnr, map)
  actions.select_default:replace(function()
    actions.close(prompt_bufnr)
    local selection = action_state.get_selected_entry()
    -- you can look at the selection with `:messages`
    print(vim.inspect(selection))
    vim.api.nvim_put({ selection[1] }, "", false, true)
  end)
  return true
end -- attach_mappings

finder = finders.new_table({
  results = {
    { "red", "#ff0000" },
    { "green", "#00ff00" },
    { "blue", "#0000ff" },
  },
  entry_maker = function(entry)
    return {
      value = entry,
      display = entry[1],
      ordinal = entry[1],
    }
  end,
})
