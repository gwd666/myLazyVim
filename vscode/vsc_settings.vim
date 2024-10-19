" "# settings.vim

" Better Navigation between VSC windows
nnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
xnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
nnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
xnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
nnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
xnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
nnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
xnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
" resizing editor windows
nnoremap <silent> <C-w>_ :<C-u>call VSCodeNotify('workbench.action.toggleEditorWidths')<CR>
" calling which-key in VSC
nnoremap <silent> <Space> :call VSCodeNotify('whichkey.show')<CR>
xnoremap <silent> <Space> :call VSCodeNotify('whichkey.show')<CR>

" Open definition on side/aside (default keybinding)
nnoremap <C-w>gd <Cmd>call VSCodeNotify('editor.action.revealDefinitionAside')<CR>

" Find in files for word under cursor
nnoremap ? <Cmd>call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>')})<CR>

" Format selection (default binding)
xnoremap = <Cmd>call VSCodeCall('editor.action.formatSelection')<CR>
nnoremap = <Cmd>call VSCodeCall('editor.action.formatSelection')<CR><Esc>
nnoremap == <Cmd>call VSCodeCall('editor.action.formatSelection')<CR>

" try to make VS Code switch between realative in normal and absolute in
" insert mode line numbers
" augroup ToggleRelLineNumbers
"   autocmd InsertLeave * call VSCodeNotify('settings.cycle.ToggleLineNumbers')
"   autocmd InsertEnter * call VSCodeNotify('settings.cycle.ToggleLineNumbers')
" augroup END

" new method no longer needing settings.cycle.ToggleLineNumbers
augroup ToggleRelLineNumbers
  autocmd InsertLeave lua.require('vscode').update_config("editor.lineNumbers", "relative", "global")
  autocmd InsertEnter lua.require('vscode').update_config("editor.lineNumbers", "on", "global")
augroup END

" Toggle zen mode with comma zz - added this in VSC in the keybindings.json
" there as a {"keys": "oem_comma+zz", ...} bingding in VSC on Winodws now
" still keeping this here as well does not seem to harm anything
nnoremap <silent> ,zz <Cmd>call VSCodeCall('workbench.action.toggleZenMode')<CR>

" close buffer with comma-c
nnoremap <silent> ,c <Cmd>call VSCodeCall('workbench.action.closeActiveEditor')<CR>
" some lines ie calling the vim.api.exec incl last line after augroup
" don't go too well in VSC on WINdows! but this way it doesn't error in VSC,
" so fine with me to keep it this way here
" vim.api.nvim_exec([[
" THEME CHANGER
function! SetCursorLineNrColorInsert(mode)
  " Insert mode: blue
  if a:mode == "i"
    call VSCodeNotify('nvim-theme.insert')
    " Replace mode: red
  elseif a:mode == "r"
    call VSCodeNotify('nvim-theme.replace')
  endif
endfunction

augroup CursorLineNrColorSwap
  autocmd!
  autocmd ModeChanged *:[vV\x16]* call VSCodeNotify('nvim-theme.visual')
  autocmd ModeChanged *:[R]* call VSCodeNotify('nvim-theme.replace')
  autocmd InsertEnter * call SetCursorLineNrColorInsert(v:insertmode)
  autocmd InsertLeave * call VSCodeNotify('nvim-theme.normal')
  autocmd CursorHold * call VSCodeNotify('nvim-theme.normal')
augroup END
" ]], false)

