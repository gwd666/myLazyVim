local M = {}

-- Example configuration (from jackplus-xyz/scroll-it.nvim):
-- Choose how line numbers behave in synchronized windows.
-- Options: "all" | "others" | "none"
-- "all": Show line numbers in all windows
-- "none": Hide line numbers in all synchronized windows
-- "others": Hide line numbers in all but the focused window
-- Expose via M so cycle and autocmd can read the live value
M.hide_line_number = "others"

-- Internal: try/catch-style helpers
local function getwinopt(name, win)
  local ok, val = pcall(vim.api.nvim_get_option_value, name, { win = win })
  return ok, val
end

local function setwinopt(name, value, win)
  return pcall(vim.api.nvim_set_option_value, name, value, { win = win })
end

-- Determine windows that are "related" for styling: same buffer and scrollbind enabled
local function wins_for_same_buffer(focused_win)
  local wins = {}
  local buf = vim.api.nvim_win_get_buf(focused_win)
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_is_valid(win) then
      local wbuf = vim.api.nvim_win_get_buf(win)
      if wbuf == buf then
        table.insert(wins, win)
      end
    end
  end
  return wins
end

local function any_scrollbind_enabled(wins)
  for _, win in ipairs(wins) do
    local ok_scb, scb = getwinopt("scrollbind", win)
    if ok_scb and scb then
      return true
    end
  end
  return false
end

local function apply_line_number_style(focused_win)
  local wins = wins_for_same_buffer(focused_win)
  if #wins == 0 then
    return
  end
  if not any_scrollbind_enabled(wins) then
    return
  end
  for _, win in ipairs(wins) do
    local show
    if M.hide_line_number == "all" then
      show = true
    elseif M.hide_line_number == "none" then
      show = false
    else -- "others": show only in focused window
      show = (win == focused_win)
    end
    pcall(vim.api.nvim_set_option_value, "number", show, { win = win })
  end
end

local function restore_line_numbers_for_buffer(focused_win)
  local wins = wins_for_same_buffer(focused_win)
  local global_number = vim.go.number
  for _, win in ipairs(wins) do
    pcall(vim.api.nvim_set_option_value, "number", global_number, { win = win })
  end
end

-- Align the current window's cursor/scroll with the previously focused window, if both use scrollbind.
local function align_with_prev_window()
  local prev_nr = vim.fn.winnr("#")
  if prev_nr == 0 then
    return
  end
  local cur_win = 0
  local prev_id = vim.fn.win_getid(prev_nr)
  local ok_cur, cur_scb = getwinopt("scrollbind", cur_win)
  local ok_prev, prev_scb = getwinopt("scrollbind", prev_id)
  if not (ok_cur and ok_prev and cur_scb and prev_scb) then
    return
  end
  local pos = vim.api.nvim_win_get_cursor(prev_id)
  pcall(vim.api.nvim_win_set_cursor, cur_win, pos)
  pcall(vim.cmd, "silent! syncbind")
end

-- Create autocmd to keep lines in sync when jumping between splits.
do
  local group = vim.api.nvim_create_augroup("ScrollbindSync", { clear = true })
  vim.api.nvim_create_autocmd("WinEnter", {
    group = group,
    callback = function()
      align_with_prev_window()
      -- Ensure line number visibility follows focus when using scrollbind
      apply_line_number_style(vim.api.nvim_get_current_win())
    end,
    desc = "Align cursor with previous window when scrollbind is active",
  })
end

-- Toggle the 'scrollbind' and 'cursorbind' window-local options for the given window (defaults to current).
function M.toggle(win)
  local w = win or 0 -- 0 = current window
  local ok_get, scb = getwinopt("scrollbind", w)
  if not ok_get then
    vim.notify("Unable to get 'scrollbind' option", vim.log.levels.ERROR)
    return
  end

  local new_val = not scb
  local ok_s, err_s = setwinopt("scrollbind", new_val, w)
  if not ok_s then
    vim.notify("Failed to toggle 'scrollbind': " .. tostring(err_s), vim.log.levels.ERROR)
    return
  end
  -- Keep cursor positions coupled as well
  setwinopt("cursorbind", new_val, w)

  if new_val then
    pcall(vim.cmd, "silent! syncbind")
    -- Apply line number preferences across related windows
    apply_line_number_style(vim.api.nvim_get_current_win())
  else
    -- If none of the windows for this buffer have scrollbind anymore, restore numbers for all of them
    local cur = vim.api.nvim_get_current_win()
    local wins = wins_for_same_buffer(cur)
    if not any_scrollbind_enabled(wins) then
      restore_line_numbers_for_buffer(cur)
    else
      -- Otherwise just refresh styling for the remaining enabled windows
      apply_line_number_style(cur)
    end
  end

  vim.notify(
    string.format("scrollbind: %s  •  cursorbind: %s", new_val and "ON" or "OFF", new_val and "ON" or "OFF"),
    vim.log.levels.INFO,
    { title = "Window" }
  )
end

-- Optional user command: :ToggleScrollbind
pcall(vim.api.nvim_create_user_command, "ToggleScrollbind", function()
  M.toggle(0)
end, { desc = "Toggle window 'scrollbind' incl. 'cursorbind'" })

-- Cycle hide_line_number between: all -> others -> none, and re-apply styling
function M.cycle_hide_line_number()
  if M.hide_line_number == "all" then
    M.hide_line_number = "others"
  elseif M.hide_line_number == "others" then
    M.hide_line_number = "none"
  else
    M.hide_line_number = "all"
  end
  apply_line_number_style(vim.api.nvim_get_current_win())
  vim.notify("hide_line_number: " .. M.hide_line_number, vim.log.levels.INFO, { title = "Scrollbind" })
end

pcall(vim.api.nvim_create_user_command, "ScrollbindCycleNumbers", function()
  M.cycle_hide_line_number()
end, { desc = "Cycle line number mode: all/others/none" })

return M
