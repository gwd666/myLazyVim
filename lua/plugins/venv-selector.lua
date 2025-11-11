return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } }, -- optional: you can also use fzf-lua, snacks, mini-pick instead.
  },
  ft = "python", -- Load when opening Python files
  keys = {
    { "<leader>V", "<cmd>VenvSelect<cr>" },
  },
  opts = {
    search = {
      conda_environmets_txt = {
        -- command = "fd python.exe$ E:/WinEnvs/mamba/envs --full-path --color never -a -I -L -E /proc -E Scripts/ -E Lib/",
        command = "bat C:/Users/gwd/.conda/environments.txt",
        type = "anaconda",
      },
    },
    options = {
      on_venv_activate_callback = function()
        local command_run = false

        local function run_shell_command()
          local source = require("venv-selector").source()
          local python = require("venv-selector").python()

          if source == "poetry" and command_run == false then
            local command = "poetry env use " .. python
            vim.api.nvim_feedkeys(command .. "\n", "n", false)
            command_run = true
          end
        end

        vim.api.nvim_create_augroup("TerminalCommands", { clear = true })

        vim.api.nvim_create_autocmd("TermEnter", {
          group = "TerminalCommands",
          pattern = "*",
          callback = run_shell_command,
        })
      end,
    },
  },
}
