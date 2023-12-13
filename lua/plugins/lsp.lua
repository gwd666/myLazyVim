-- trying to remap lsp signature_help from C-k to C-o
return {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
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
