local map = vim.keymap.set
return {
  -- tele/zettelkasten
  {
    "renerocksai/telekasten.nvim",
    lazy = false, -- load at startup
    opts = {
      home = vim.fn.expand("~/zettelkasten"),
    },
    keys = {
      -- Telekasten / Zettelkasten mappings
      -- launch panel is nothing is typed after leader-T
      map(
        "n",
        "<leader>T",
        "<cmd>Lazy load telekasten.nvim<CR><CMD>Telekasten panel<CR>",
        { desc = "Launch Telekasten panel" }
      ),
      -- most used/common Telekasten functions
      map("n", "<leader>Tf", "<cmd>Telekasten find_notes<CR>", { desc = "TKasten find Notes" }),
      map("n", "<leader>Ts", "<cmd>Telekasten search_notes<CR>", { desc = "TKasten search Notes" }),
      map("n", "<leader>Td", "<cmd>Telekasten goto_today<CR>", { desc = "TKasten goto Today" }),
      map("n", "<leader>Tl", "<cmd>Telekasten follow_link<CR>", { desc = "TKasten follow Link" }),
      map("n", "<leader>Tn", "<cmd>Telekasten new_note<CR>", { desc = "Tkasten New Note" }),
      map("n", "<leader>Tc", "<cmd>Telekasten show_calendar<CR>", { desc = "TKasten show Calendar" }),
      map("n", "<leader>Tb", "<cmd>Telekasten show_backlinks<CR>", { desc = "TKasten show Backlinks" }),
      map("n", "<leader>TI", "<cmd>Telekasten insert_img_link<CR>", { desc = "TKasten insert IMG link" }),
      -- Call insert link automatically when we start typing a link
      map("i", "[[", "<cmd>Telekasten insert_link<CR>", { desc = "TKasten insert Link" }),
    },
  },
}
