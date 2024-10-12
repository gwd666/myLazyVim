-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

local wk = require("which-key")

-- vim.g.mapleader = "," -- Make sure to set `mapleader` before lazy so your mappings are correct
-- fast editing and reloading of init.lua config embed vimscript code in vim.cmd(.....)
-- use vim.cmd([[   ]]) for multi-line
vim.cmd([[
autocmd! bufwritepost ~/AppData/Local/nvim/init.lua source ~/AppData/Local/nvim/init.lua
]])

-- map ,ee to quick edit of init.lua
map("n", ",ee", ":e! ~/AppData/Local/nvim/init.lua<CR>", { silent = false, desc = "Edit nvim/init.lua file" })

-- map comma+c to close buffer
map("n", ",c", ":bd<CR>:bnext<CR>", { silent = true, desc = "Close current Buffer move to next" })

-- reset the <S-h> and <S-h> mappings to the default behaviour
vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")

-- toggle paste
map({ "n", "i", "v", "x" }, "<F6>", "<cmd>set invpaste<CR><cmd>set paste?<CR>", { desc = "Toggle PASTE mode" })

-- map jk to switch to Normal mode in Terminal
map("t", "jk", [[<C-\><C-n>]], { silent = true })
map("t", "<ESC>", [[<C-\><C-n>]], {})
map("t", "<M-[>", [[<C-\><C-n>]], {})
map("t", "<C-w>", [[<C-\><C-n><C-w>]], {})
map("t", "<M-r>", [['<C-\><C-N>"'.nr2char(getchar()).'pi']], { expr = true })

-- Keep matches center screen when cycling with n|N etc.
map("n", "n", "nzzzv", { noremap = true, desc = "Fwd  search '/' or '?'" })
map("n", "N", "Nzzzv", { noremap = true, desc = "Back search '/' or '?'" })
map("n", "#", "#zzz", { noremap = true, silent = true, desc = "Search word under cursor and center" })
map("n", "<C-o>", "<C-o>zz", { noremap = true, silent = true })

-- remove WIN CRLF meta char when encoding get messed up
map("n", ",m", "mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm", { desc = "Fix ^M or Windows CRLF meta chars in file" })

-- map jk to ESC
map("i", "jk", "<ESC>", { silent = true })
map("i", "jj", "<ESC>", { silent = true })

-- map F3 [no longer <C-t>] to toggle Neotree
map("n", "<F3>", ":Neotree toggle<CR>", { silent = true, desc = "NTree toggle" })
map("n", "<F2>", ":Neotree buffers<CR>", { silent = true, desc = "NTree buffers" })

-- map <comma>CD (upppercase CD) to change working dir to curr buffer parent dir
map("n", "<leader>CD", ":Neotree %:h<CR>", { silent = true, desc = "Set the NeoTree active dir to buffer's dir" })

-- Map <leader>o & <leader>O to newline when in Normal mode ie w/o being followed by insert mode
map(
  "n",
  "<leader>o",
  [[:<C-u>call append(line("."), repeat([""], v:count1))<CR>]],
  { silent = true, desc = "Newline below (no insert-mode)" }
)
map(
  "n",
  "<leader>O",
  [[:<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>]],
  { silent = true, desc = "Newline above (no insert-mode)" }
)

-- map Ctrl-h and Ctrl-l to move cursor left/right in INSERT mode, map C-u to undo last edit?
map("i", "<C-h>", "<left>", { noremap = true, silent = true })
map("i", "<C-l>", "<right>", { noremap = true, silent = true })
map("i", "<C-j>", "<down>", { noremap = true, silent = true })
map("i", "<C-k>", "<up>", { noremap = true, silent = true })
map("i", "<C-u>", "<C-g>u<C-u>", { noremap = true, silent = true })

-- remap arrow keys deactivate movements in buffer all together
map("n", "<left>", ":bp<CR>", { noremap = true, silent = true, desc = "Previous buffer" })
map("n", "<right>", ":bn<CR>", { noremap = true, silent = true, desc = "Next buffer" })
map("n", "<up>", ":tabnext<CR>", { noremap = true, silent = true, desc = "Next tab" })
map("n", "<down>", ":tabprev<CR>", { noremap = true, silent = true, desc = "Previous tab" })

-- toggle zen mode w Comma-zz
map("n", ",zz", ":ZenMode<CR>", { noremap = true, silent = true, desc = "Toggle ZenMode" })

-- telscope mappings
local builtin = require("telescope.builtin")
map("n", "<leader>ff", builtin.find_files, { desc = "Tele find Files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Tele grep Live" })
map("n", "<leader>fs", builtin.grep_string, { desc = "Tele grep String (under cursor)" })
map("n", "<leader>fb", builtin.buffers, { desc = "Tele Buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Tele Help tags" })
map("n", "<leader>fk", builtin.keymaps, { desc = "Tele 'n' mode kmaps" })
map("n", "<leader>fm", "<cmd>NoiceTelescope<CR>", { desc = "NoiceTelescope messages/notificatons" })

-- find Lazy configuration files
vim.api.nvim_set_keymap(
  "n",
  "<Leader>fp",
  "<CMD>lua require('telescope.builtin').find_files({ cwd = require('lazy.core.config').options.root, desc = 'Plugins'})<CR>",
  -- "<CMD>lua require'tele-git_find_file-config'.project_files()<CR>",
  { noremap = true, silent = true, desc = "Find 'plugins' files" }
)
-- map Leader-Space to telscoping projects
vim.api.nvim_set_keymap(
  "n",
  "<leader><Space>",
  "<cmd>lua require'telescope'.extensions.project.project{}<CR>",
  { noremap = true, silent = true, desc = "Show projects" }
)

-- add a telescope lsp keymap and which-key group
-- (
--   --- suggested new spec - accordding to checkhealth which-key
--   {
--     { "<leader>t", group = "Telekasten/TSitter/Lsp" },
--     { "<leader>td", builtin.lsp_definitions, desc = "Lsp Definitions" },
--     { "<leader>ts", builtin.lsp_document_symbols, desc = "Lsp Docu Symbols" },
--     { "<leader>tx", builtin.treesitter, desc = "TreeSitter Funcs/Vars Ref" },
--   }
-- )

-- chatigpt mappings
wk.add({
  mode = { "v", "n" },
  { "<leader>G", group = "ChatGPT" },
  { "<leader>Gc", group = "ChatGPT" },
  { "<leader>Gca", "<cmd>ChatGPTRun add_tests<CR>", desc = "Add Tests" },
  { "<leader>Gcc", "<cmd>ChatGPT<CR>", desc = "ChatGPT" },
  { "<leader>Gcd", "<cmd>ChatGPTRun docstring<CR>", desc = "Docstring" },
  { "<leader>Gce", "<cmd>ChatGPTEditWithInstruction<CR>", desc = "Edit with instruction" },
  { "<leader>Gcf", "<cmd>ChatGPTRun fix_bugs<CR>", desc = "Fix Bugs" },
  { "<leader>Gcg", "<cmd>ChatGPTRun grammar_correction<CR>", desc = "Grammar Correction" },
  { "<leader>Gck", "<cmd>ChatGPTRun keywords<CR>", desc = "Keywords" },
  { "<leader>Gcl", "<cmd>ChatGPTRun code_readability_analysis<CR>", desc = "Code Readability Analysis" },
  { "<leader>Gco", "<cmd>ChatGPTRun optimize_code<CR>", desc = "Optimize Code" },
  { "<leader>Gcr", "<cmd>ChatGPTRun roxygen_edit<CR>", desc = "Roxygen Edit" },
  { "<leader>Gcs", "<cmd>ChatGPTRun summarize<CR>", desc = "Summarize" },
  { "<leader>Gct", "<cmd>ChatGPTRun translate<CR>", desc = "Translate" },
  { "<leader>Gcx", "<cmd>ChatGPTRun explain_code<CR>", desc = "Explain Code" },
  { "<leader>Gce", "<cmd>ChatGPTEditWithInstruction<CR>", desc = "Edit with instruction" },
})

-- OLD STYLE DEFINTIONS w/o local map
-- map Ctrl-PgUp/PgDown to move between buffers in NORMAL mode
map("n", "<C-PageUp>", ":bp<CR>", { silent = true, desc = "Prev buff" })
map("n", "<C-PageDown>", ":bn<CR>", { silent = true, desc = "Next buff" })
-- also in INSERT mode
map("i", "<C-PageUp>", ":bp<CR>", { silent = true })
map("i", "<C-PageDown>", ":bn<CR>", { silent = true })
-- map <leader><Space> to remove search hhighlighting
map("n", ",<Space>", ":nohls<CR>", { silent = true, desc = "Remove highlighting on search results" })

-- mappaig Meta+minus to insert <- in insert mode
map("i", "<M-->", " <- ", { noremap = true, silent = true })
map("i", "<C-_>", " -> ", { noremap = true, silent = true }) -- Meta+Shift+minus opens terminal below

-- iron.nvim REPL has a bunch of commands,
-- see :h iron-commands for all available commands you might wanna map
map("n", "<leader>rs", "<cmd>IronRepl<cr>", { desc = "IronRepl start" })
map("n", "<leader>rr", "<cmd>IronRestart<cr>", { desc = "IronRepl restart" })
map("n", "<leader>rf", "<cmd>IronFocus<cr>", { desc = "IronRepl focus" })
map("n", "<leader>rh", "<cmd>IronHide<cr>", { desc = "IronRepl hide" })

-- telekasten mappings
-- Launch panel if nothing is typed after <leader>z
map("n", "<leader>t", "<cmd>Telekasten panel<CR>")
-- Most used functions
map("n", "<leader>tf", "<cmd>Telekasten find_notes<CR>")
map("n", "<leader>tg", "<cmd>Telekasten search_notes<CR>")
map("n", "<leader>tt", "<cmd>Telekasten goto_today<CR>")
map("n", "<leader>tz", "<cmd>Telekasten follow_link<CR>")
map("n", "<leader>tn", "<cmd>Telekasten new_note<CR>")
map("n", "<leader>tc", "<cmd>Telekasten show_calendar<CR>")
map("n", "<leader>tq", "<cmd>bw!<CR>", { desc = "Close Calendar panel." })
map("n", "<leader>tb", "<cmd>Telekasten show_backlinks<CR>")
map("n", "<leader>tI", "<cmd>Telekasten insert_img_link<CR>")
-- Call insert link automatically when we start typing a link
map("i", "[[", "<cmd>Telekasten insert_link<CR>")

-- add some dbee keymaps
map("n", "<leader>db", "<cmd>lua require('dbee').open()<CR>", { desc = "Open DB editor", silent = true })
map(
  "n",
  "<leader>dc",
  "<cmd>lua require('dbee').close()<CR>",
  { desc = "Close DB editor(also press <leader>q", silent = true }
)

-- send-to-term mappings
-- map("n", "Tl", "<Plug>SendLine", { silent = false, desc = "Send line to Term" })
-- map("n", "Ts", "<Plug>Send", { silent = false, desc = "Send motion to Term" })
-- map("v", "Ts", "<Plug>Send", { silent = false, desc = "Send visual to Term" })

-- ( -- Terminal and Lsp/TreeSitter group
wk.add({
  { "<leader>T", group = "Terminal/TSitter/Lsp" },
  -- new terminal in normal mode below current window size 25
  { "<leader>Tb", "<cmd>below 25sp term://zsh<CR>", desc = "New terminal below" },
  { "<leader>Tr", "<cmd>rightb :vert :term<CR>", desc = "New terminal vertical split on right" },
  { "<leader>Td", require("telescope.builtin").lsp_definitions, desc = "Lsp Definitions" },
  { "<leader>Ts", require("telescope.builtin").lsp_document_symbols, desc = "Lsp Docu Symbols" },
  { "<leader>Tx", require("telescope.builtin").treesitter, desc = "TreeSitter Funcs/Vars Ref" },
})
map("n", "TS", "ts$")
