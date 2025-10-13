-- trying to remap lsp signature_help from C-k to C-o
return {
  "neovim/nvim-lspconfig",
  dependencies = { "saghen/blink.cmp" },
  init = function()
    lspconfig = require("lspconfig")
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- modifying the keymaps for lsp ie. deactivating c-k for signature help in insert mode
    keys[#keys + 1] = { "<C-k>", mode = "i", false }
    keys[#keys + 1] =
      { "<C-o>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "SignatureHelp" }

    opts = { -- some lines to fix mason and lsp conflicts for rust-analyzer
      setup = {
        rust_analyzer = function()
          return true
        end,
      },
    }
    -- have a look at https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
    -- for customization of the floating window borders etc.
    vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]])
    vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=grey guibg=#1f2335]])
    vim.cmd([[autocmd! ColorScheme * highlight FloatTitle guifg=grey guibg=#1f2335]])

    local border = {
      { "🭽", "FloatBorder" },
      { "▔", "FloatBorder" },
      { "🭾", "FloatBorder" },
      { "▕", "FloatBorder" },
      { "🭿", "FloatBorder" },
      { "▁", "FloatBorder" },
      { "🭼", "FloatBorder" },
      { "▏", "FloatBorder" },
    }
    -- LSP settings (for overriding per client) -
    -- start by defining a local handler table
    local handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
      -- ["textDocmumen/functionInfo"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single"}),
      ["textDocmumen/functionInfo"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
    }

    -- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
    local lsp = vim.lsp -- comment this out and use vim.lsp instead
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = border, -- "single", -- "rounded",
    })

    -- ############################################################################
    lspconfig.julials.setup({
      filetypes = {
        "julia",
        "juliamarkdown",
        "juliamarkdown.pandoc",
        "juliamarkdown.latex",
        "juliamarkdown.html",
      },
      on_attach = on_attach,
      handlers = handlers,
      -- commenting out root-dir for julia lsp seems to work without it
      -- and it seems to be causing issues with other functionnality
      -- root_dir = lspconfig.util.root_pattern("Project.toml", "JuliaProject.toml", ".git", vim.fn.getcwd()),
    })

    -- lua lsp setup if major usage is with Neovim
    require("lspconfig").lua_ls.setup({
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if
            path ~= vim.fn.stdpath("config")
            and (vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc"))
          then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              -- Depending on the usage, you might want to add additional paths here.
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            },
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
            -- library = vim.api.nvim_get_runtime_file("", true)
          },
        })
      end,
      settings = {
        Lua = {},
      },
    })
  end,
}
