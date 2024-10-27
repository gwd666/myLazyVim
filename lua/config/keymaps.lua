-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local wk = require("which-key")
local opt = { silent = true }

map("n", "<leader><leader>", function()
  local is_git = os.execute("git") == 0
  if is_git then
    require("telescope.builtin").git_files()
  else
    require("telescope.builtin").find_files()
  end
end)

-- vim.g.mapleader = "," -- Make sure to set `mapleader` before lazy so your mappings are correct
-- fast editing and reloading of init.lua config embed vimscript code in vim.cmd(.....)
-- use vim.cmd([[   ]]) for multi-line
vim.cmd([[
autocmd! bufwritepost ~/.config/nvim/init.lua source ~/.config/nvim/init.lua
]])

map("n", ",ee", ":e! ~/.config/nvim/init.lua<CR>", { silent = false, desc = "Edit nvim/init.lua file" })

-- map comma+c to 'close buffer'
map("n", ",c", ":bd<CR>:bnext<CR>:Neotree show<CR>", { silent = true, desc = "Close current Buffer" })

-- reset or umnap the <S-h> and <S-h> mappings to some default behaviour
-- ie Shift H to move to top and Shift L to move to bottom
-- some plugin hijacked these keys
vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")

-- toggle paste
map(
  { "n", "i", "v", "x" },
  "<F6>",
  "<cmd>set invpaste<CR><cmd>set paste?<CR>",
  { silent = false, desc = "Toggle PASTE mode" }
)

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

-- Replace All - original from: https://gist.github.com/GllmR/80de5fb8824a758bafdb390e0a471480
-- that giist is a single file init.lua ... but ut has lazy and all of it included as well
vim.keymap.set(
  "n",
  "<leader>h",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { noremap = true, desc = "Sed/Replace global" }
)

-- remove WIN CRLF meta char when encoding get messed up
map("n", ",m", "mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm", { desc = "Fix Windows CRLF meta chars" })

-- map jk to ESC
map("i", "jk", "<ESC>", { noremap = true, silent = true })
map("i", "jj", "<ESC>", { noremap = true, silent = true })

-- map F2-4 [no longer <C-t>] to toggle Neotree
-- note: you can switch between those Neotree tabs 'Files', 'Buffers', 'Git' with "<" and ">" key
map("n", "<F2>", ":Neotree show source=filesystem toggle=true<CR>", { silent = true, desc = "NTree toggle" })
map("n", "<F3>", ":Neotree source=buffers toggle=true<CR>", { silent = true, desc = "NTree buffers" })
map("n", "<F4>", ":Neotree source=git_status float toggle=true<CR>", { silent = true, desc = "NTree git_status" })

-- map <comma>CD (upppercase CD) to change working dir to curr buffer parent dir
map("n", "<leader>CD", ":Neotree %:h<CR>", { silent = true, desc = "Set NeoTree active dir to buffer's dir" })

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

-- map Ctrl-h, Ctrl-l, j, k to move cursor left/right/down/up in INSERT mode,
-- map C-u to undo last edit?
map("i", "<C-h>", "<left>", { noremap = true, silent = true })
map("i", "<C-j>", "<down>", { noremap = true, silent = true })
map("i", "<C-k>", "<up>", { noremap = true, silent = true })
map("i", "<C-l>", "<right>", { noremap = true, silent = true })
map("i", "<C-u>", "<C-g>u<C-u>", { noremap = true, silent = true })

-- remap arrow keys to move between buffers and tabs
map("n", "<left>", ":bp<CR>", { noremap = true, silent = true })
map("n", "<right>", ":bn<CR>", { noremap = true, silent = true })
map("n", "<up>", ":tabnext<CR>", { noremap = true, silent = true })
map("n", "<down>", ":tabprev<CR>", { noremap = true, silent = true })

-- toggle zen mode w Comma-zz
map("n", ",zz", ":ZenMode<CR>", { desc = "Toggle ZenMode" })

-- telescope mappings
local builtin = require("telescope.builtin")
map("n", "<leader>ff", builtin.find_files, { desc = "Tscope find Files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Tscope grep Live" })
map("n", "<leader>fs", builtin.grep_string, { desc = "Tscope grep String (under cursor)" })
map("n", "<leader>fb", builtin.buffers, { desc = "Tscope Buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Tscope Help tags" })
map("n", "<leader>fk", builtin.keymaps, { desc = "Tscope 'n' mode kmaps" })

map("n", "<leader>fm", "<cmd>NoiceTelescope<CR>", { desc = "NoiceTelescope message/notifications" })

-- find Lazy configuration files
map(
  "n",
  "<leader>fp",
  "<cmd>lua require('telescope.builtin').find_files({ cwd = require('lazy.core.config').options.root, desc = 'Plugins'})<CR>",
  -- "<cmd>lua require'tele-git_find_file-config'.project_files()<CR>",
  { noremap = true, silent = true, desc = "Find 'plugins' files" }
)

map( -- vim.keymap.set is non-recursive by default so noemrap is not needed
  "n",
  "<leader>P",
  "<cmd>lua require'telescope'.extensions.project.project{}<CR>",
  { silent = true, desc = "Show projects" }
)

-- before the whole ChatGPT group below is added here is a simple quock CopilotChat mappings
-- on thos of the default ones you get after hitting <leader>a (for AI I guess)
-- CopilotChat since leader+cc is recerved for Run-Codelens use Capital C's
vim.keymap.set("n", "<leader>CC", ":CopilotChatToggle<CR>", opt)

-- chatgpt mappings
-- local gpt = require("chatgpt")
wk.add( --  a shot at adding GPT group
  -- {
  -- prefix = "<leader>",
  -- mode = { "v", "n" },
  -- G = {
  --   name = "ChatGPT",
  --   e = {
  --     function()
  --       gpt.edit_with_instructions()
  --     end,
  --     "Edit with instructions",
  --   }
  -- },
  --     c = {
  --       name = "ChatGPT",
  --       a = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
  --       c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
  --       d = { "<cmd>ChatGPTun docstring<CR>", "Docstring", mode = { "n", "v" } },
  --       e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
  --       f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
  --       g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
  --       k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
  --       l = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis", mode = { "n", "v" } },
  --       o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
  --       r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
  --       s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
  --       t = { "<cmd>ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
  --       x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
  --     },
  --   },
  -- }
  { -- with mode as a predefined table upfront
    mode = { "n", "v" },
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
  }
)

-- some AI mappings - not used currently, since I am not using AI plugins anymore
-- map("n", "<leader>aa", ":AI<CR>", { desc = "Complete text on current line or selection" })
-- map("x", "<leader>aa", ":AI<CR>", { desc = "Complete text on current line or selection" })
--
-- map("n", "<leader>as", ":AIEdit fix grammar and spelling<CR>", { desc = "Edit text with a custom prompt" })
-- map("x", "<leader>as", ":AIEdit fix grammar and spelling<CR>", { desc = "Edit text with a custom prompt" })
--
-- map("n", "<leader>ac", ":AIChat<CR>", { desc = "Trigger Chat" })
-- map("x", "<leader>ac", ":AIChat<CR>", { desc = "Trigger Chat" })
--
-- map("n", "<leader>ar", ":AIRedo<CR>", { desc = "Redo last AI command" })

-- OLD STYLE DEFINTIONS w/o local map
-- map leader-c to close buffer
-- map("n", "<leader>c", ":bd<CR>")
-- map Ctrl-PgUp/PgDown to move between buffers in NORMAL mode
map("n", "<C-PageUp>", ":bp<CR>", { silent = true, desc = "Prev buff" })
map("n", "<C-PageDown>", ":bn<CR>", { silent = true, desc = "Next buff" })
-- also in INSERT mode - does not work in ISNERT mode - comment out!
-- map("i", "<C-PageUp>", ":bp<CR>", { silent = true, desc = "previous buffer" })
-- map("i", "<C-PageDown>", ":bn<CR>", { silent = true, desc = "next buffer" })
-- map <leader><Space> to remove search highlightings
map("n", ",<Space>", ":nohls<CR>", { silent = true, desc = "Remove highlighting on search results" })

-- mapping Meta+minus to insert <- in insert mode
map("i", "<M-->", " <- ", { noremap = true, silent = true })
map("i", "<C-_>", " -> ", { noremap = true, silent = true }) -- Meta+Shit+minus opens Terminal below?

-- iron.nvim REPL has a bunch of commands,
-- see :h iron-commands for all available commands you might wanna map
-- map("n", "<leader>rs", "<cmd>IronRepl<cr>", { desc = "IronRepl start" })
-- map("n", "<leader>rr", "<cmd>IronRestart<cr>", { desc = "IronRepl restart" })
-- map("n", "<leader>rf", "<cmd>IronFocus<cr>", { desc = "IronRepl focus" })( -- map("n", "<leader>rh", "<cmd>IronHide<cr>", { desc = "IronRepl hide" })
-- ({
--   {
--     mode = { "n" },
--     { "<leader>r", group = "IronRepl", desc = "IronRepl" },
--     { "<leader>rs", "<cmd>IronRepl<cr>", desc = "IronRepl start" },
--     { "<leader>rr", "<cmd>IronRestart<cr>", desc = "IronRepl restart" },
--     { "<leader>rf", "<cmd>IronFocus<cr>", desc = "IronRepl focus" },
--   },
-- })

-- telekasten mappings
-- Launch panel if nothing is typed after <leader>t
map("n", "<leader>t", "<cmd>Telekasten panel<CR>")
-- Most used Telekasten functions
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
-- Calendar keybindings
-- map("n", "<C-Right>", "<cmd>lua require('telekasten').goto_next_month()<CR>")

-- nnn.nvim bindings currenly only in Ubuntu
map("n", "<C-M-n>", "<cmd>NnnExplorer %:p:h<CR>", { desc = "Open nnn Explorer in curr buffer" })
map("n", "<C-M-p>", ":NnnPicker<CR>", { desc = "Open nnn Picker in curr buffer" })

-- add some dbee keymaps
-- map("n", "<leader>db", "<cmd>lua require('dbee').open()<CR>", { desc = "Open DB editor", silent = true })
-- map(
--   "n",
--   "<leader>dc",
--   "<cmd>lua require('dbee').close()<CR>",
--   { desc = "Close DB editor(also press <leader>q", silent = true }
-- )
--
-- -- add some nvim-dbee keymaps
-- map("n", "<leader>db", "<cmd>lua require('dbee').open()<CR>", { desc = "Open dbee DB editor", silent = true })
-- map(
--   "n",
--   "<leader>dc",
--   "<cmd>lua require('dbee').close())<CR>",
--   { desc = "Close DB editor (also press leader-q)", silent = true }
-- )
-- send-to-term mappings
-- map("n", "tl", "<plug>sendline", { silent = false, desc = "send line to term" })
-- map("n", "ts", "<plug>send", { silent = false, desc = "send motion to term" })
-- map("v", "ts", "<plug>send", { silent = false, desc = "send visual to term" })
-- map("n", "ts", "ts$")

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

-- keymaps for HARPOON - all starting with M- (Alt) key
-- and UPPERCASE letters except for M-q to toggle the harpoon quick menu
local harpoon = require("harpoon")
wk.add({
  { "<leader>H", group = "Harpoon" },
  -- { "<leader>Hq", "<cmd>lua require'harpoon.ui'.toggle_quick_menu()<CR>", desc = "Harpoon QuickMenu" },
  { "<leader>HT", "<cmd>Telescope harpoon marks<CR>", desc = "Telescope Harpoon marks" },
  {
    "<leader>Ha",
    function()
      harpoon:list():add()
    end,
    desc = "Add Harpoon mark",
  },
  {
    "<leader>Hq",
    function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end,
    desc = "Harpoon QuickMenu",
  },
  {
    "<leader>H1",
    function()
      harpoon:list():select(1)
    end,
    desc = "Goto File 1",
  },
  {
    "<leader>H2",
    function()
      harpoon:list():select(2)
    end,
    desc = "Goto File 2",
  },
  {
    "<leader>H3",
    function()
      harpoon:list():select(3)
    end,
    desc = "Goto File 3",
  },
  {
    "<leader>H4",
    function()
      harpoon:list():select(4)
    end,
    desc = "Goto File 4",
  },
  {
    "<leader>Hn",
    function()
      harpoon:list():next()
    end,
    desc = "Goto next Harpoon mark",
  },
  {
    "<leader>Hp",
    function()
      harpoon:list():prev()
    end,
    desc = "Goto previous Harpoon mark",
  },
})
-- here are some additional real harpoon "shortcuts" ie just two keys at most, but w/o the which-key group
-- toggle the Harpoon QuickMenu with M-q ie Alt-q
vim.keymap.set("n", "<M-q>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { silent = true, desc = "Toggle Harpoon QuickMenu" })
-- -- show harpoon marks in Telescope w M-Q
vim.keymap.set("n", "<M-Q>", ":Telescope harpoon marks<CR>", { silent = false, desc = "Telescope Harpoon marks" })
-- -- add harpoons
vim.keymap.set("n", "<M-a>", function()
  harpoon:list():add()
end, { silent = false, desc = "Add Harpoon file mark" })
-- -- switch to M-N uppercase since lowercase acts like C-n
vim.keymap.set("n", "<M-N>", function()
  harpoon:list():next()
end, { silent = true, desc = "Goto next Harpoon mark" })
-- switch to M-N uppercase since lowercase M-n acts like C-p
vim.keymap.set("n", "<M-P>", function()
  harpoon:list():prev()
end, { silent = true, desc = "Goto previous Harpoon mark" })

-- workaruond from here: https://github.com/ThePrimeagen/harpoon/issues/178#issuecomment-1174520639
map(
  "n",
  "<leader>hh",
  "<cmd>lua require('telescope').extensions.harpoon.marks({attach_mappings=function(_, map) map('i', '<c-d>', require('telescope.actions').preview_scrolling_down) return true end})<CR>",
  { noremap = true, desc = "Remap harpoon preview screen to scroll down" }
)

-- vim.keymap.set("n", "<leader>fH", "<cmd>Telescope harpoon marks<CR>", { desc = "Open Telescope harpoon window" })

-- end of keymaps.lua
