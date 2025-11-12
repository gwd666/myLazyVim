-- set to `true` to follow the main branch
-- you need to have a working rust toolchain to build the plugin
-- in this case.
vim.g.lazyvim_blink_main = false

-- adding this based on ocaml update infos
-- vim.cmd("set rtp^='/home/gwd/.opam/default/share/ocp-indent/vim'")
-- vim.cmd("set rtp^='/home/gwd/.opam/default/share/ocp-indent/vim'")

-- share clipboard with system clipboard
vim.opt.clipboard = "unnamedplus"

-- ignore case when searching
vim.cmd("set ignorecase")

-- ignore cse if pattern is only lowercase - if there's a capital letter in the search, it's case-sensitive
vim.cmd("set smartcase")

-- disable the calendar.vim keybindings - b/c of conflicts with code mappings
-- therefore the bindings are all set in hte keybindings.lua file
vim.cmd("let g:calendar_no_mappings = 1")

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

-- for Windows uncomment the following line to set/use Powershell 7 as terminal
vim.opt.shell = "pwsh"

-- send-to-term options for multiline text eg IPython etc -- deactivated, relying on iron.repl now
-- vim.cmd([[
--   let g:send_multiline = {
--   \    'ipy': {'begin':"\e[200~", 'end':"\e[201~\n", 'newline':"\n"},
--   \    'r': {'begin':"\e[200~", 'end':"\e[201~\n", 'newline':"\n"},
--   \    'jl': {'begin':"\e[200~", 'end':"\e[201~\n", 'newline':"\n"},
--   \}
-- ]])
