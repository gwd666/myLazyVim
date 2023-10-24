-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- change linenumbering to relative except for current line
-- but switch to absolute in INSERT mode
vim.cmd([[
augroup numbertoggle
 autocmd!
 autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i"  | set rnu    | endif
 autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                   | set nornu  | endif
augroup END
]])

-- make j and l move to prev/next line
vim.opt.whichwrap = "<>[],hl,b,s"

-- customize better ws
vim.cmd("let g:better_whitespace_operator='_s'") -- <leader>s is alrealy taken in LazyVim
-- menans you can do <numbber>_s<space> to strip ws on number lines, _s<motion> on lines affected by motion
-- _sip will clean on current paragraph, etc
vim.keymap.set("n", "_ws", ":ToggleWhitespace<CR>", { silent = false, desc = "Toggle show Whitespace" })
vim.cmd("let g:better_whitespace_ctermcolor='Gray'")
vim.cmd("let g:better_whitespace_guicolor='Gray'")
vim.cmd("let g:better_whitespace_skip_emptylines=1") -- don't  bother with empty lines other pliugin will handle that
-- vim.cmd("let g:stip_whitespace_on_save=1") -- this would disable stripping ws on save
-- highlight ws that precedes Tabs, plugin cannot remove those,
-- BUT you can try to fix indentation by slecting and hitting '=' key!
vim.cmd("let g:show_spaces_that_precede_tabs=1")

-- send-to-term options for multiline text eg IPython etc
vim.cmd([[
  let g:send_multiline = {
  \    'ipy': {'begin':"\e[200~", 'end':"\e[201~\n", 'newline':"\n"},
  \    'r': {'begin':"\e[200~", 'end':"\e[201~\n", 'newline':"\n"},
  \    'jl': {'begin':"\e[200~", 'end':"\e[201~\n", 'newline':"\n"},
  \}
]])
