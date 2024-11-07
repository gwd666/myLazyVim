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

-- adding this based on ocaml update infos
vim.cmd("set rtp^='/home/gwd/.opam/default/share/ocp-indent/vim'")

-- share clipboard with system clipboard
vim.opt.clipboard = "unnamedplus"

-- ignore case when searching
vim.cmd("set ignorecase")

-- ignore cse if pattern is only lowercase - if there's a capital letter in the search, it's case-sensitive
vim.cmd("set smartcase")

-- disable the calendar.vim keybindings - b/c of conflicts with code mappings
-- therefore the bindings are all set in hte keybindings.lua file
vim.cmd("let g:calendar_no_mappings = 1")

-- set terminal options to make it look more like a terminal
vim.cmd([[
augroup neovim_terminal
    autocmd!
    " Enter Terminal-mode (insert) automatically
    autocmd TermOpen * startinsert
    " Disables number lines on terminal buffers
    autocmd TermOpen * :set nonumber norelativenumber
    " allows you to use Ctrl-c on terminal window
    autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
augroup END
]])

-- make j and l move to prev/next line
vim.opt.whichwrap = "<>[],hl,b,s"

-- activate nice arrows for linebreak
vim.cmd("set listchars+=eol:↲")

-- enable autocompletions as you type
-- vim.opt.completion_enable_auto_popup = 1
vim.cmd("let g:completion_enable_auto_popup=1")

-- customize better ws
vim.cmd("let g:better_whitespace_operator='_s'") -- <leader>s is alrealy takek in LazyVim

-- means you can do <number>_s<space> to strip ws on number lines, _s<motion> on lines affected by motion
-- _sip will clean on current paragraph, etc
vim.keymap.set("n", "_ws", ":ToggleWhitespace<CR>", { silent = false, desc = "Toggle show Whitespace" })
vim.cmd("let g:better_whitespace_ctermcolor='Gray'")
vim.cmd("let g:better_whitespace_guicolor='Gray'")
vim.cmd("let g:better_whitespace_skip_emptylines=1") -- don't  bother with empty lines other pliugin will handle that
-- vim.cmd("let g:stip_whitespace_on_save=1") -- this would disable stripping ws on save
-- highlight ws that precedes Tabs, plugin cannot remove those,
-- BUT you can try to fix indentation by slecting and hitting '=' key!
vim.cmd("let g:show_spaces_that_precede_tabs=1")

-- need conceallevel of 1 or 2 for obsidian.nvim to manage format concealment
vim.opt.conceallevel = 1

-- madox2/vim-ai config
-- vim.cmd([[
-- let g:vim_ai_chat = {
-- \ "options": {
-- \    "model": "gpt-4",
-- \    "temperature": 0.1,
-- \ },
-- \}
-- ]])

-- send-to-term options for multiline text eg IPython etc -- deactivated, relying on iron.repl now
-- vim.cmd([[
--   let g:send_multiline = {
--   \    'ipy': {'begin':"\e[200~", 'end':"\e[201~\n", 'newline':"\n"},
--   \    'r': {'begin':"\e[200~", 'end':"\e[201~\n", 'newline':"\n"},
--   \    'jl': {'begin':"\e[200~", 'end':"\e[201~\n", 'newline':"\n"},
--   \}
-- ]])
