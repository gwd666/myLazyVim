-- helper func
local has_py3 = vim.fn.has("python3") > 0
-- adding some tex/latex support
return {
  { "lervag/vimtex" },
  { "SirVer/ultisnips", cond = has_py3, event = { "InsertEnter", "CmdlineEnter" } },
  { "honza/vim-snippets" },
  { "tpope/vim-dispatch" },
}
