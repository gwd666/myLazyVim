-- add Primeagens harpoon
return {
  {
    "ThePrimeagen/harpoon",
    config = function()
      require("harpoon").setup()
      require("telescope").load_extension("harpoon")
    end,
  },
  -- }  "ThePrimeagen/harpoon",
  -- local harpoon=require("harpoon")
  --
  --   init = function()
  --     harpoon:setup()
  --     require("telescope").load_extension("harpoon")
  --   end,
}
-- on the difference between config and init see:
-- https://www.reddit.com/r/neovim/comments/17f9pqi/comment/k68ea52/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
