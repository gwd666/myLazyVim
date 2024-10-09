-- ==========================================--
-- **** MY [GWD] NVIM CONFIG ****************--
-- ==========================================--
-- => General
-- ==========================================--

-- in case of vscode-neovim, set clipboard to unnamedplus
if vim.g.vscode then
  -- VSC extension
  print("Looks like you're starting Neovim for VSC reading init.lua from WSL!")
  -- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  -- require("config/keymaps")
  -- require("")
  -- https://github.com/vscode-neovim/vscode-neovim/issues/298
  -- vim.opt.clipboard:append("unnamedplus")
  print("Running clipboard setting for vscode-neovim")
  vim.cmd([[source /home/gwd/.config/nvim/vscode/vsc_settings.vim]])
  --- ignorecase and unnamedplus are found in option.lua
  -- vim.opt.clipboard:append("unnamedplus")
  -- vim.cmd("set clipboard=unnamedplus")
  -- vim.cmd("set ignorecase") -- ignore case when searching
  require("config/options")
else
  -- print("=== Sourcing " .. os.getenv("HOME") .. ".config/nvim/init.lua " .. " part =====")
  -- I am gonna ride with SPACE as LEADER for now to test the feeling
  -- ----------------------------------------------------------------------------
  vim.g.mkdp_echo_preview_url = 1 -- default was 0 -> make MarkdownPreviewwe show the localhost URL for Peviewerh
  -- some vimscript settings
  vim.cmd("set autochdir")
  -- set colorcolumns
  vim.cmd("set colorcolumn=80,120")
  --swet a dedicated python2 host
  vim.cmd("let g:python3_host_prog='/usr/bin/python3'")
  -- telekasten require
  -- ----------------------------------------------------------------------------
  -- Start the bootstrap of lazy.nvim, LazyVim and your plugins
  -- bootstrap lazy.nvim, LazyVim and your plugins
  require("config.lazy")
  -- load telescope config
  require("config.telescope")
  require("config.chatgpt")
  -- moved all the colorscheme stuff to plugins/colorscheme.lua
  -- define the colorscheme
  -- vim.api.nvim_command([[ colorscheme catppuccin-mocha ]])
  -- vim.api.nvim_command([[ colorscheme catppuccin-frappe ]])
  -- vim.api.nvim_command([[ colorscheme tokyonight-storm ]])
  -- vim.api.nvim_command([[ colorscheme gruvbuddy ]])
  -- vim.api.nvim_command([[ colorscheme onenord ]])
  -- vim.api.nvim_command([[ colorscheme onedarker ]])
  -- vim.api.nvim_command([[ colorscheme material-palenight ]])
  vim.api.nvim_command([[ colorscheme monokai-pro-machine ]])
  -- vim.api.nvim_command([[ colorscheme monokai-pro-octagon ]])
  -- vim.api.nvim_command([[ colorscheme gruvbox-material ]])
  -- telekasten setup
  require("telekasten").setup({
    home = vim.fn.expand("~/zettelkasten"), -- Put the name of your notes directory here
  })
  ------------------------------------------------------------------------------
  -- print("=== Finished " .. os.getenv("HOME") .. ".config/nvim/init.lua " .. " part =====")
end
