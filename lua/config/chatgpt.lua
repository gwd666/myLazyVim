local home = vim.fn.expand("$USERPROFILE")
require("chatgpt").setup({ -- for the below to work you need to run gpg -d secret.txt.gpg in terminal before starting nvim
  -- api_key_cmd = "gpg --decrypt C:\\Users\\gwd\\secret.txt.gpg",
  api_key_cmd = "gpg --decrypt " .. home .. "\\secret.txt.gpg",
  chat = {
    keymaps = { --somehow the M ie Meta key does not get pikced up here - but works in harpoon?!
      toggle_help = "<M-H>", -- I wanted to change <C-h> to <M-h> ie ALt+h like for other Telescope windows
    },
  },
})
