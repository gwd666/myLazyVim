-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

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

-- new terminal in normal mode below current window size 25
map("n", "<leader>Tt", ":botright 25sp<CR><C-w>:term<CR><C-w>J", { silent = true, desc = "New Terminal below" })

-- Keep matches center screen when cycling with n|N etc.
map("n", "n", "nzzzv", { noremap = true, desc = "Fwd  search '/' or '?'" })
map("n", "N", "Nzzzv", { noremap = true, desc = "Back search '/' or '?'" })
map("n", "#", "#zzz", { noremap = true, silent = true, desc = "Search word under cursor and center" })
map("n", "<C-o>", "<C-o>zz", { noremap = true, silent = true })

-- remove WIN CRLF meta char when encoding get messed up
map("n", ",m", "mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm", { desc = "Fix Windows CRLF meta chars" })

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
map("n", "<left>", ":bp<CR>", { noremap = true, silent = true })
map("n", "<right>", ":bn<CR>", { noremap = true, silent = true })
map("n", "<up>", ":tabnext<CR>", { noremap = true, silent = true })
map("n", "<down>", ":tabprev<CR>", { noremap = true, silent = true })

-- toggle zen mode w Comma-zz
map("n", ",zz", ":ZenMode<CR>", { noremap = true, silent = true, desc = "Toggle ZenMode" })

-- telscope mappings
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Tele find Files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Tele grep Live" })
vim.keymap.set("n", "<leader>fs", builtin.grep_string, { desc = "Tele grep String (under cursor)" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Tele Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Tele Help tags" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Tele 'n' mode kmaps" })
vim.keymap.set("n", "<leader>fm", "<cmd>NoiceTelescope<CR>", { desc = "NoiceTelescope messages/notificatons" })

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
local wk = require("which-key")

-- (
--   --- suggested new spec - accordding to checkhealth which-key
--   {
--     { "<leader>t", group = "Telekasten/TSitter/Lsp" },
--     { "<leader>td", builtin.lsp_definitions, desc = "Lsp Definitions" },
--     { "<leader>ts", builtin.lsp_document_symbols, desc = "Lsp Docu Symbols" },
--     { "<leader>tx", builtin.treesitter, desc = "TreeSitter Funcs/Vars Ref" },
--   }
-- )

wk.register({
  t = {
    name = "Telekasten/TSitter/Lsp",
    d = { builtin.lsp_definitions, "Lsp Definitions" },
    s = { builtin.lsp_document_symbols, "Lsp Docu Symbols" },
    x = { builtin.treesitter, "TreeSitter Funcs/Vars Ref" },
    -- l = { builtin.lsp_reference, "Lsp reference" }, -- not owrking correctly - TBD
  },
}, { prefix = "<leader>" })
-- chatigpt mappings
local chatgpt = require("chatgpt")
wk.register({
  mode = { "v", "n" },
  prefix = "<leader>",
  p = {
    name = "ChatGPT",
    e = {
      function()
        chatgpt.edit_with_instructions()
      end,
      "Edit with instructions",
    },
    c = {
      name = "ChatGPT",
      c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
      e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
      g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
      t = { "<cmd>ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
      k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
      d = { "<cmd>ChatGPTun docstring<CR>", "Docstring", mode = { "n", "v" } },
      a = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
      o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
      s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
      f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
      x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
      r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
      l = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis", mode = { "n", "v" } },
    },
  },
})

-- OLD STYLE DEFINTIONS w/o local map
-- map Ctrl-PgUp/PgDown to move between buffers in NORMAL mode
vim.keymap.set("n", "<C-PageUp>", ":bp<CR>", { silent = true, desc = "Prev buff" })
vim.keymap.set("n", "<C-PageDown>", ":bn<CR>", { silent = true, desc = "Next buff" })
-- also in INSERT mode
vim.keymap.set("i", "<C-PageUp>", ":bp<CR>", { silent = true })
vim.keymap.set("i", "<C-PageDown>", ":bn<CR>", { silent = true })
-- map <leader><Space> to remove search hhighlighting
vim.keymap.set("n", ",<Space>", ":nohls<CR>", { silent = true, desc = "Remove highlighting on search results" })

-- iron.nvim REPL has a bunch of commands,
-- see :h iron-commands for all available commands you might wanna map
vim.keymap.set("n", "<leader>rs", "<cmd>IronRepl<cr>", { desc = "IronRepl start" })
vim.keymap.set("n", "<leader>rr", "<cmd>IronRestart<cr>", { desc = "IronRepl restart" })
vim.keymap.set("n", "<leader>rf", "<cmd>IronFocus<cr>", { desc = "IronRepl focus" })
vim.keymap.set("n", "<leader>rh", "<cmd>IronHide<cr>", { desc = "IronRepl hide" })

-- telekasten mappings
-- Launch panel if nothing is typed after <leader>z
vim.keymap.set("n", "<leader>t", "<cmd>Telekasten panel<CR>")

-- Most used functions
vim.keymap.set("n", "<leader>tf", "<cmd>Telekasten find_notes<CR>")
vim.keymap.set("n", "<leader>tg", "<cmd>Telekasten search_notes<CR>")
vim.keymap.set("n", "<leader>tt", "<cmd>Telekasten goto_today<CR>")
vim.keymap.set("n", "<leader>tz", "<cmd>Telekasten follow_link<CR>")
vim.keymap.set("n", "<leader>tn", "<cmd>Telekasten new_note<CR>")
vim.keymap.set("n", "<leader>tc", "<cmd>Telekasten show_calendar<CR>")
vim.keymap.set("n", "<leader>tb", "<cmd>Telekasten show_backlinks<CR>")
vim.keymap.set("n", "<leader>tI", "<cmd>Telekasten insert_img_link<CR>")

-- add some dbee keymaps
map("n", "<leader>db", "<cmd>lua require('dbee').open()<CR>", { desc = "Open DB editor", silent = true })
map(
  "n",
  "<leader>dc",
  "<cmd>lua require('dbee').close()<CR>",
  { desc = "Close DB editor(also press <leader>q", silent = true }
)

-- Call insert link automatically when we start typing a link
vim.keymap.set("i", "[[", "<cmd>Telekasten insert_link<CR>")

-- send-to-term mappings
map("n", "Tl", "<Plug>SendLine", { silent = false, desc = "Send line to Term" })
map("n", "Ts", "<Plug>Send", { silent = false, desc = "Send motion to Term" })
map("v", "Ts", "<Plug>Send", { silent = false, desc = "Send visual to Term" })
map("n", "TS", "ts$")
