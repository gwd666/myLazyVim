-- init.lua install headlines.nvim
return {
  "lukas-reineke/headlines.nvim",
  config = function()
    require("headlines").setup({
      markdown = {
        headline_highlights = {
          "Headline1",
          "Headline2",
          "Headline3",
          "Headline4",
          "Headline5",
          "Headline6",
        },
        codeblock_highlight = "CodeBlock",
        dash_highlight = "Dash",
        quote_highlight = "Quote",
      },
    })
  end,
}
