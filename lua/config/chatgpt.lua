local home = vim.fn.expand("$HOME")

WELCOME_MESSAGE = [[
 
     If you don't ask the right questions,
        you don't get the right answers.
                                      ~ Robert Half
]]

require("chatgpt").setup({ -- for the below to work you need to run gpg -d secret.txt.gpg in terminal before starting nvim
  api_key_cmd = "gpg --decrypt " .. home .. "/SER7_KEY-SHELL-GPT_OPENAI-API.gpg",
  edit_with_instructions = {
    keymaps = {
      toggle_help = "<M-h>", -- I changed it from <C-h> to <M-h> ie ALt+h like for other Telescope windows
    },
  },
  chat = {
    welcome_message = WELCOME_MESSAGE,
    keymaps = {
      toggle_help = "<M-h>", -- I changed it from <C-g> to <M-h> ie ALt+g like for other Telescope windows
      select_session = "<Space>a",
    },
  },
  openai_params = {
    model = "o3-mini-high",
    temperature = 0.2,
    max_tokens = 1024, -- use 512 for gpt-4o
    frequency_penalty = 0,
    presence_penalty = 0,
    top_p = 1,
    n = 1,
    stop = "```", -- this was suggested for usage with openai models for coding as well
  },
})
