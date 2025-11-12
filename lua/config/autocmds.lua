-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- MY CUSTOM AUFTOCMDS (moved over here from options.lua)
-- change linenumbering to relative except for current line
-- but switch to absolute in INSERT mode
vim.cmd([[
augroup numbertoggle
 autocmd!
 autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i"  | set rnu    | endif
 autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                   | set nornu  | endif
augroup END
]])

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

-- How to Open binary files
-- pdf
vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = "*.pdf",
  callback = function()
    local filename = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
    vim.cmd("silent !mupdf " .. filename .. " &")
    vim.cmd("let tobedeleted = bufnr('%') | b# | exe \"bd! \" . tobedeleted")
  end,
})
-- other
vim.api.nvim_create_autocmd("BufReadCmd", {
  pattern = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
  callback = function()
    local filename = vim.fn.shellescape(vim.api.nvim_buf_get_name(0))
    vim.cmd("silent !eyestalk " .. filename .. " &")
    vim.cmd("let tobedeleted = bufnr('%') | b# | exe \"bd! \" . tobedeleted")
  end,
})
