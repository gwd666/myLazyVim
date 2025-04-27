local home = vim.fn.expand("$USERPROFILE")

WELCOME_MESSAGE = [[
 
     If you don't ask the right questions,
        you don't get the right answers.
                                      ~ Robert Half
]]

require("chatgpt").setup({ -- for the below to work you need to run gpg -d secret.txt.gpg in terminal before starting nvim
  -- api_key_cmd = "gpg --decrypt C:\\Users\\gwd\\secret.txt.gpg",
  api_key_cmd = "C:\\msys64\\usr\\bin\\gpg.exe --decrypt " .. home .. "\\SER7_SHELL-GPT-OPENAI_API.gpg",
  edit_with_instructions = {
    keymaps = {
      toggle_help = "<M-h>", -- I changed it from <C-h> to <M-h> ie ALt+h like for other Telescope windows
    },
  },
  chat = {
    welcome_message = WELCOME_MESSAGE,
    keymaps = {
      toggle_help = "<M-h>", -- I changed it from <C-g> to <M-g> ie ALt+g like for other Telescope windows
      select_session = "<Space>a",
    },
  },
  openai_params = {
    model = "gpt-4o",
    temperature = 0.1,
    max_tokens = 300,
    frequency_penalty = 0,
    presence_penalty = 0,
    top_p = 1,
    n = 1,
  },
})
