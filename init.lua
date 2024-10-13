-- ==========================================--
-- **** MY [GWD] NVIM CONFIG ****************--
-- ==========================================--
-- => General
-- ==========================================--

if vim.g.vscode then
  -- VSC extension
  print("Looks like you're starting Neovim for VSC reading from WINDOWS init.lua!")
  -- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  require("config/options") -- this makes H/L move to prev/mext line, etc
  -- require("config/keymaps")
  -- ...
  -- https://github.com/vscode-neovim/vscode-neovim/issues/298
  print("Running clipboard setting for vscode-neovim")
  vim.opt.clipboard:append("unnamedplus")
  -- vim.cmd("set clipboard=unnamedplus")
  vim.cmd("set ignorecase") -- Ignore case when searching
  vim.cmd([[source $HOME\AppData\Local\nvim\vscode\vsc_settings.vim]])
else
  -- print("=== Sourcing " .. os.getenv("USERPROFILE") .. "/init.lua " .. os.getenv("USERNAME") .. " part =====")
  -- I am gonna ride with SPACE as LEADER for now to test the feeling
  -- ----------------------------------------------------------------------------
  -- some vimscript settings
  vim.cmd("set autochdir")
  -- set colorcolumns
  vim.cmd("set colorcolumn=80,120")
  -- set a dedicated python3 host
  vim.cmd("let g:python3_host_prog='E:/WinEnvs/mamba/envs/py311/python'") --set python3 host to avoid surprises
  -- ----------------------------------------------------------------------------
  -- Start the bootstrap of lazy.nvim, LazyVim and your plugins
  -- load telescope config
  require("config.lazy")
  require("config.telescope")
  require("config.chatgpt")
  -- moved all the colorscheme stuff to plugins/colorscheme.lua
  -- define the colorscheme
  -- use tokyonight cs in telescope mod fashion - this will only work from her on since needs require call above to work
  -- vim.api.nvim_command([[ colorscheme tokyonight ]])
  -- vim.api.nvim_command([[ colorscheme tokyonight-storm ]])
  -- vim.api.nvim_command([[ colorscheme habamax ]])
  -- vim.api.nvim_command([[ colorscheme catppuccin-frappe ]])
  -- vim.api.nvim_command([[ colorscheme catppuccin-mocha ]])
  -- vim.api.nvim_command([[ colorscheme catppuccin-frappe ]])
  -- vim.api.nvim_command([[ colorscheme gruvbox-material ]])
  -- vim.api.nvim_command([[ colorscheme gruvbuddy ]])
  vim.api.nvim_command([[ colorscheme onenord ]])
  -- vim.api.nvim_command([[ colorscheme onedarker ]])
  -- vim.api.nvim_command([[ colorscheme material-palenight ]])
  -- vim.api.nvim_command([[ colorscheme monokai-pro-machine ]])
  -- vim.api.nvim_command([[ colorscheme monokai-pro-octagon ]])
  -- vim.api.nvim_command([[ colorscheme monokai-pro-ristretto ]])
  -- vim.api.nvim_command([[ colorscheme gruvbox-material ]])
  -- vim.api.nvim_command([[ colorscheme zaibatsu ]])
  -- handle a weird path error in cse neovim is started in Git Bash
  if os.getenv("TERM") == "xterm-256color" and os.getenv("SHELL") == "C:\\Program Files\\Git\\usr\\bin\\bash.exe" then
    print("Neovim started in Git Bash? Modifying/Fixing SHELL env var!")
    vim.cmd([[ let &shell = '"C:/Program Files/Git/usr/bin/bash.exe"']])
  end
  -- telekasten setpu
  require("telekasten").setup({
    home = vim.fn.expand("C:/Users/gwd/Docs@OneDrive/zettelkasten"), -- Put the name of your notes directory here
  })
  -- print("=== Finished " .. os.getenv("USERPROFILE") .. "/init.lua " .. os.getenv("USERNAME") .. " part =====")
end
