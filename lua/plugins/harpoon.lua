-- add Primeagens harpoon

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  requires = { { "nvim-lua//plenary.nvim" } },
  -- REQUIRED
  -- REQUIRED
  init = function()
    local harpoon = require("harpoon")
    harpoon:setup()
    require("telescope").load_extension("harpoon")
    -- keymaps
    vim.keymap.set("n", "<M-Q>", ":Telescope harpoon marks<CR>", { silent = false, desc = "Telescope Harpoon marks" })
    vim.keymap.set("n", "<M-q>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { silent = true, desc = "Toggle Harpoon QuickMenu" })

    vim.keymap.set("n", "<M-a>", function()
      harpoon:list():append()
    end, { silent = false, desc = "Add Harpoon file mark" })

    vim.keymap.set("n", "<M-1>", function()
      harpoon:list():select(1)
    end, { silent = true, desc = "Goto File 1" })

    vim.keymap.set("n", "<M-2>", function()
      harpoon:list():select(2)
    end, { silent = true, desc = "Goto File 2" })

    vim.keymap.set("n", "<M-3>", function()
      harpoon:list():select(3)
    end, { silent = true, desc = "Goto File 3" })

    vim.keymap.set("n", "<M-4>", function()
      harpoon:list():select(4)
    end, { silent = true, desc = "Goto File 4" })

    vim.keymap.set("n", "<M-n>", function()
      harpoon:list():next()
    end, { silent = true, desc = "Goto next Harpoon mark" })

    vim.keymap.set("n", "<M-p>", function()
      harpoon:list():prev()
    end, { silent = true, desc = "Goto previous Harpoon mark" })

    -- deprecated harpoon 1 keymaps you can tell by not being funcion() calls
    vim.keymap.set(
      "n",
      "<M-0>",
      ':lua require("harpoon.term").gotoTerminal(1)<CR>',
      { silent = true, desc = "Goto Terminal 1 create if not" }
    )
  end,
}
