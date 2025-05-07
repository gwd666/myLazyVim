return {
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      WELCOME_MESSAGE = [[
      If you/gwd don't ask the right questions,
      you do not get the right answers.
                                  ~ Robert Half
      ]]
      require("chatgpt").setup({
        api_key_cmd = "gpg --decrypt /home/gwd/SER7_KEY-SHELL-GPT_OPENAI-API.gpg",
        edit_with_instructions = {
          keymaps = {
            toggle_help = "<M-h>", -- I changed that one from to <M-h> ie ALT+h like for other Telescope windows
          },
        },
        chat = {
          welcome_message = WELCOME_MESSAGE,
          default_system_message = "You are a helpful assistant, expected to support me with software development and coding tasks using the following programming languages (sorted in decreasing order of relevance for me): Python, R, Julia, C, zig, Go, Rust, C++ and Ocaml. Additionally code versioning with `git` topics and questions may also arise. To wrap it all up, you can also offer advise when it comes to shell commands and scripting for `zsh` (the z-shell) and the Windows `Powershell-7` terminal. While doing so, Finance will be the domain we want to focus on, i.e. Quantitative Finance, International Accounting Standards and Financial Reporting, Trading, as well as Mathematics, Statistics, Machine Learning and Timeseries analysis and forecasting, but also technologies like blockchain, databases, cloud computing and operating systems.",
          keymaps = {
            toggle_help = "<C-h>", -- I changed it from <C-g> to <C-h> before that, it was <M-h> ie ALT+h like for other Telescope windows, but that did not work
          },
        },
        openai_params = {
          model = "gpt-4o-mini",
          -- model = "o3-mini-high",
          temperature = 0.1,
          max_tokens = 4096, -- use 1024 for 03-mini, or 512 for gpt-4o or 4096 for 4o-mini
          frequency_penalty = 0,
          presence_penalty = 0,
          top_p = 0.2,
          n = 1,
          stop = "```", -- this was suggested for usage with openai models for coding as well
        },
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim", -- optional
      "nvim-telescope/telescope.nvim",
    },
  },
}
