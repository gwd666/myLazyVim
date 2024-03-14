local home = vim.fn.expand("$HOME")
require("chatgpt").setup({ -- for the below to work you need to run gpg -d secret.txt.gpg in terminal before starting nvim
  api_key_cmd = "gpg --decrypt " .. home .. "/secret.txt.gpg",
  -- api_key_cmd = "gpg --decrypt /home/gwd/secret.txt.gpg",
  chat = {
    keymaps = {
      toggle_help = "<M-h>", -- I changed it from <C-h> to <M-h> ie ALt+h like for other Telescope windows
    },
  },
})
