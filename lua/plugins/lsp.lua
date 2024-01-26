-- trying to remap lsp signature_help from C-k to C-o
-- and adjusting R lsp lang-server setup
return {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    local lspconfig = require("lspconfig")
    -- modify R languageserver call since R is mapped to Invoke-History in PShell
    lspconfig.r_language_server.setup({
      cmd = { "R.exe", "--slave", "-e", "languageserver::run()" },
      filetypes = { "r", "R", "rmd" },
      -- root_dir = lpsconfig.util.root_pattern(".git", vim.fn.getcwd()),
    })
    keys[#keys + 1] = { "<C-k>", mode = "i", false }
    keys[#keys + 1] =
      { "<C-o>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "SignatureHelp" }
    -- include folliwing lines to avoid scanning C:\Users\gwd ie the home dir
    root_dir = function(fname)
      local root_pattern = lsp.util.root_pattern(".git")(fname)
      if fname == vim.loop.os_homedir() then
        return nil
      end
      return root_pattern or fname
    end
  end,
}
