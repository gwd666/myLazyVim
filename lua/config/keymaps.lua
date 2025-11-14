-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local wk = require("which-key")

local opt = { silent = true }

local builtin = require("telescope.builtin")

vim.cmd([[
  autocmd! bufwritepost ~/.config/nvim/init.lua source ~/.config/nvim/init.lua
]])

-- alternative mapleader -> sticking with Space for now
-- vim.g.mapleader = "," -- Make sure to set `mapleader` before lazy so your mappings are correct

-- besided the CAPSLOCK being mapped to ESC via PowerToys Input/Output Remapper, here's the usual jk jj to ESC as well
-- map jk to ESC
map("i", "jk", "<ESC>", { noremap = true, silent = true })
map("i", "jj", "<ESC>", { noremap = true, silent = true })

-- map jk to switch to Normal mode in Terminal as well
map("t", "jk", [[<C-\><C-n>]], { silent = true })
map("t", "<ESC>", [[<C-\><C-n>]], {})
map("t", "<M-[>", [[<C-\><C-n>]], {})
map("t", "<C-w>", [[<C-\><C-n><C-w>]], {})
map("t", "<M-r>", [['<C-\><C-N>"'.nr2char(getchar()).'pi']], { expr = true })

-- toggle paste with F6
map(
  { "n", "i", "v", "x" },
  "<F6>",
  "<cmd>set invpaste<CR><cmd>set paste?<CR>",
  { silent = false, desc = "Toggle PASTE mode" }
)

-- Edit init.lua
map("n", ",ee", ":e! ~/.config/nvim/init.lua<CR>", { silent = false, desc = "Edit nvim/init.lua file" })

-- map semi-colon+c to 'close buffer'
map("n", ";c", ":bd<CR>:bnext<CR>:Neotree show %h<CR>", { silent = true, desc = "Close current Buffer move to next" })

-- remove WIN CRLF meta char when encoding get messed up
map("n", ",m", "mmHmt:%s/<C-V><CR>//ge<CR>'tzt'm", { desc = "Fix Windows CRLF meta chars" })

-- map <comma>CD (upppercase CD) to set dir to curr buffer parent dir
map("n", "<leader>CD", ":Neotree %:h<CR>", { silent = true, desc = "Set NeoTree active dir to buffer's dir" })
map("n", "<leader>e", ":Neotree toggle %:h<CR>", { silent = true, desc = "Explorer NeoTree (Root/Buffer Dir)" })

-- map Ctrl-h, Ctrl-l to move cursor left/right in INSERT mode
-- blink.lua disables these keys inside the completion menu so these mappings always win
map("i", "<C-h>", "<left>", { noremap = true, silent = true })
map("i", "<C-l>", "<right>", { noremap = true, silent = true })
map("i", "<C-j>", "<down>", { noremap = true, silent = true, desc = "Move cursor down" })
map("i", "<C-k>", "<up>", { noremap = true, silent = true, desc = "Move cursor up" })
-- undo in insert mode with Ctrl-u
map("i", "<C-u>", "<C-g>u<C-u>", { noremap = true, silent = true })

-- remap arrow keys to move between buffers and tabs
map("n", "<left>", ":bp<CR>", { noremap = true, silent = true })
map("n", "<right>", ":bn<CR>", { noremap = true, silent = true })
map("n", "<up>", ":tabnext<CR>", { noremap = true, silent = true })
map("n", "<down>", ":tabprev<CR>", { noremap = true, silent = true })

-- toggle zen mode w Comma-zz
map("n", ";z", ":lua Snacks.zen()<CR>", { silent = true, desc = "Toggle ZenMode" })

-- ctrlspace
map("n", "<C-Space>", ":CtrlSpace<CR>", { silent = true, desc = "CtrlSpace window at bottom" })

-- some additional Telescope f..find mappings
local tsBuiltin = require("telescope.builtin")
map("n", "<leader>fh", tsBuiltin.help_tags, { desc = "Tscope Help tags" })
map("n", "<leader>fk", tsBuiltin.keymaps, { desc = "Tscope 'n' mode kmaps" })

map("n", "<leader>fm", "<cmd>NoiceTelescope<CR>", { desc = "NoiceTelescope message/notifications" })

-- OLD STYLE DEFINTIONS w/o local map
-- another close buffer mappping with <leader>c
-- map("n", "<leader>c", ":bd<CR>")
-- map Ctrl-PgUp/PgDown to move between buffers in NORMAL mode
map("n", "<C-PageUp>", ":bp<CR>", { silent = true, desc = "Prev buff" })
map("n", "<C-PageDown>", ":bn<CR>", { silent = true, desc = "Next buff" })
-- also in INSERT mode - does not work in INSERT mode - so comment out for now!
--
-- map("i", "<C-PageUp>", ":bp<CR>", { silent = true, desc = "previous buffer" })
-- map("i", "<C-PageDown>", ":bn<CR>", { silent = true, desc = "next buffer" })
-- map <leader><Space> to remove search highlightings
map("n", ",<Space>", ":nohls<CR>", { silent = true, desc = "Remove highlighting on search results" })

-- some scrollbind for buffers/windows mapping
map("n", "<leader>wS", function()
  require("config.scrollbind").toggle()
end, { silent = true, desc = "Toggle scrollbind for this window" })

-- map Ctrl+A to enter insert mode at end of file
map("n", "<C-A>", "Go", { noremap = true, silent = true })

-- using nvim_put to paste text via function other methods did not work as expected
-- The first argument is a table of lines to paste.
-- The second argument is the register type (`"c"` for characterwise).
-- The third argument is whether to paste after the cursor (`true`).
-- The fourth argument is whether to move the cursor (`true`).

-- mapping ALT or Meta+minus to insert <- R assignment operator in insert mode
map("i", "<M-->", function()
  vim.api.nvim_put({ " <- " }, "c", true, true)
end, { noremap = true, silent = true })
-- inserting right assignment operator, this is also the julia pipe operetor
map("i", "<C-_>", function()
  vim.api.nvim_put({ " -> " }, "c", true, true)
end, { noremap = true, silent = true }) -- Meta+Shit+minus opens Terminal below?

-- adding iron.nvim REPL bunch of mappings for its commands,
wk.add({
  {
    mode = { "n" },
    { "<leader>r", group = "IronRepl", desc = "IronRepl" },
    { "<leader>rf", "<cmd>IronRepl<cr>", desc = "IronRepl start" },
    { "<leader>rF", "<cmd>IronFocus<cr>", desc = "IronRepl focus" },
    { "<leader>rR", "<cmd>IronRestart<cr>", desc = "IronRepl restart" },
  },
})

-- ( -- Terminal and Lsp/TreeSitter group
wk.add({
  { "<leader>T", group = "Terminal/TSitter/Lsp" },
  -- new terminal in normal mode below current window size 25
  -- { "<leader>Tb", "<cmd>below 25sp term://zsh<CR>", desc = "New terminal below" },
  { "<leader>Tb", "<cmd>lua Snacks.terminal()<CR>", desc = "New terminal below" },
  { "<leader>Tr", "<cmd>rightb :vert :term<CR>", desc = "New terminal vertical split on right" },
  { "<leader>Td", require("telescope.builtin").lsp_definitions, desc = "Lsp Definitions" },
  { "<leader>Ts", require("telescope.builtin").lsp_document_symbols, desc = "Lsp Docu Symbols" },
  { "<leader>Tx", require("telescope.builtin").treesitter, desc = "TreeSitter Funcs/Vars Ref" },
})

-- telekasten mappings
-- Launch panel if nothing is typed after <leader>t
map("n", "<leader>z", "<cmd>Telekasten panel<CR>")
-- Most used Telekasten functions
map("n", "<leader>zf", "<cmd>Telekasten find_notes<CR>")
map("n", "<leader>zg", "<cmd>Telekasten search_notes<CR>")
map("n", "<leader>zt", "<cmd>Telekasten goto_today<CR>")
map("n", "<leader>zz", "<cmd>Telekasten follow_link<CR>")
map("n", "<leader>zn", "<cmd>Telekasten new_note<CR>")
map("n", "<leader>zc", "<cmd>Telekasten show_calendar<CR>")
map("n", "<leader>zq", "<cmd>bw!<CR>", { desc = "Close Calendar panel." })
map("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>")
map("n", "<leader>zI", "<cmd>Telekasten insert_img_link<CR>")
-- Call insert link automatically when we start typing a link
map("i", "[[", "<cmd>Telekasten insert_link<CR>")
-- Calendar keybindings
map("n", "<C-Right>", "<cmd>lua require('telekasten').goto_next_month()<CR>")

-- here are some additional real harpoon "shortcuts" ie just two keys at most, but w/o the which-key group
-- toggle the Harpoon QuickMenu with M-q ie Alt-q
local harpoon = require("harpoon")

vim.keymap.set("n", "<M-q>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { silent = true, desc = "Toggle Harpoon QuickMenu" })

-- show harpoon marks in Telescope w M-Q
vim.keymap.set("n", "<M-Q>", ":Telescope harpoon marks<CR>", { silent = false, desc = "Telescope Harpoon marks" })

-- add harpoons
vim.keymap.set("n", "<M-a>", function()
  harpoon:list():add()
end, { silent = false, desc = "Add Harpoon file mark" })

-- switch to M-N uppercase since lowercase acts like C-n
vim.keymap.set("n", "<M-N>", function()
  harpoon:list():next()
end, { silent = true, desc = "Goto next Harpoon mark" })

-- switch to M-N uppercase since lowercase M-n acts like C-p
vim.keymap.set("n", "<M-P>", function()
  harpoon:list():prev()
end, { silent = true, desc = "Goto previous Harpoon mark" })

-- unmap <C-A> (in normal mode: movinhg to EOF and entering insert mode in next line i.e. 'Go' combo)
vim.keymap.del("n", "<C-A>")
map("i", "<C-A>", "<Esc>Go", { silent = true, desc = "Go to EOF and enter new line" })
-- end of keymap.lua
