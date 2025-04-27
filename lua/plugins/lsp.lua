-- trying to remap lsp signature_help from C-k to C-o
-- and adjusting R lsp lang-server setup
return {
  "neovim/nvim-lspconfig",
  init = function()
    local lspconfig = require("lspconfig")
    -- local lsp = vim.lsp -- this is not needed/used decided to go w vim.lsp
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
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

    -- include folloiwing lines to avoid scanning C:\Users\gwd ie the home dir
    root_dir = function(fname)
      local root_pattern = lspconfig.util.root_pattern(".git")(fname)
      if fname == vim.loop.os_homedir() then
        return nil
      end
      return root_pattern or fname
    end

    -- have a look at https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
    -- for customization of the floating window borders etc.
    vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]])
    vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=grey guibg=#1f2335]])

    -- LSP settings (for overriding per client)
    -- define some custom borders for the floating windows
    local border = {
      -- { "🭽", "FloatBorder" },
      { "●", "FloatBorder" },
      { "▔", "FloatBorder" },
      -- { "🭾", "FloatBorder" },
      { "●", "FloatBorder" },
      { "▕", "FloatBorder" },
      -- { "🭿", "FloatBorder" },
      { "●", "FloatBorder" },
      { "▁", "FloatBorder" },
      -- { "🭼", "FloatBorder" },
      { "●", "FloatBorder" },
      { "▏", "FloatBorder" },
    }

    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {
              "vim",
              "require",
            },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    })

    -- and then defining a local handler table
    local handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
      ["textDocmumen/functionInfo"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
    }

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })

    -- modify R languageserver call since R is mapped to Invoke-History in PShell
    lspconfig.r_language_server.setup({
      cmd = { "R.exe", "--slave", "-e", "languageserver::run()" },
      filetypes = { "r", "R", "rmd" },
      -- root_dir = lpsconfig.util.root_pattern(".git", vim.fn.getcwd()),
    })

    lspconfig.powershell_es.setup({
      filetypes = { "ps1", "psm1", "psd1" },
      bundle_path = "~/AppData/Local/nvim-data/mason/packages/powershell-editor-services",
      settings = { powershell = { codeFormatting = { Preset = "OTBS" } } },
      init_options = {
        enableProfileLoading = false, -- this is important otherwise it will load the profile and not work as expected!
      },
    })

    -- the ocaml lsp server stuff is handled in plugins/mason-lsp.lua
    -- therefore this is commented out
    -- require("mason").setup()
    -- -- define my LSP servers to install including eg a version for ocamllsp
    -- local myLspServers = {
    --   "ocaml-lsp-server@1.19.0", -- this needs to fit the ocaml version available in winget
    -- }
    -- require("mason-lspconfig").setup({
    --   ensure_installed = myLspServers,
    --   automatic_installation = { true, exclude = { "ocamllsp" } },
    -- })

    -- ocaml lsp config part
    lspconfig.ocamllsp.setup({
      on_attach = on_attach,
    })

    lspconfig.julials.setup({ -- somehow makes nvim unstable or crash!!
      filetypes = {
        "jl",
        "julia",
        "jmd",
        "juliamarkdown",
        --     "juliamarkdown.pandoc",
        --     "juliamarkdown.latex",
        --     "juliamarkdown.html",
      },
      on_attach = on_attach,
      handlers = handlers,
      -- commenting out root_dir logic as it seems to work without it
      -- and it seems to cause issues w other functionality
      -- root_dir = lspconfig.util.root_pattern("Project.toml", "JuliaProject.toml", ".git", vim.fn.getcwd()),
    })

    -- Do not forget to use the on_attach function
    lspconfig.zls.setup({
      on_attach = on_attach,
      handlers = handlers,
      cmd = { "zls" },
      filetypes = { "zig", "zlr" },
      root_dir = lspconfig.util.root_pattern(".git", "build.zig", vim.fn.getcwd()),
    }) -- this put HERE - made 'zls' workk!
  end,
}
