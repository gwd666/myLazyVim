-- trying to remap lsp signature_help from C-k to C-o
return {
  "neovim/nvim-lspconfig",
  init = function()
    lspconfig = require("lspconfig")

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

    -- include following lines to avoid scanning the home dir or C:\Users\gwd
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

    -- To instead override globally
    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or border
      return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end

    local border = { -- you need to decide on round bullet or question mark corners!
      -- { "🭽", "FloatBorder" }, -- commenting these corners
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

    -- local border = {
    --   { "🭽", "FloatBorder" },
    --   { "▔", "FloatBorder" },
    --   { "🭾", "FloatBorder" },
    --   { "▕", "FloatBorder" },
    --   { "🭿", "FloatBorder" },
    --   { "▁", "FloatBorder" },
    --   { "🭼", "FloatBorder" },
    --   { "▏", "FloatBorder" },
    -- }

    -- Change border of documentation hover window, See https://github.com/neovim/neovim/pull/13998.
    -- local lsp = vim.lsp -- comment this out and use vim.lsp instead
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })

    -- LSP settings (for overriding per client) -
    -- start by defining a local handler table
    local handlers = {
      ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
      ["textDocmumen/functionInfo"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
      ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
    }

    lspconfig.julials.setup({
      filetypes = {
        "julia",
        "juliamarkdown",
        -- "juliamarkdown.pandoc",
        -- "juliamarkdown.latex",
        -- "juliamarkdown.html",
      },
      on_attach = on_attach,
      handlers = handlers,
      -- commenting out root-dir for julia lsp semme to work without it
      -- and it seems to be causing issues with other functionnality
      -- root_dir = lspconfig.util.root_pattern("Project.toml", "JuliaProject.toml", ".git", vim.fn.getcwd()),
    })

    --  try to fix ""multiple different client offset_encodings detected" warning for clangd lsp
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    lspconfig.clangd.setup({
      on_attach = on_attach,
      capabilities = cmp_nvim_lsp.default_capabilities(),
      cmd = {
        "clangd",
        "--offset-encoding=utf-16",
      },
    })

    lspconfig.gopls.setup({
      on_attach = on_attach,
      filetypes = { "go", "gomod" },
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
          gofumpt = true,
        },
      },
      root_dir = lspconfig.util.root_pattern("go.mod", ".git", vim.fn.getcwd()),
    })

    lspconfig.powershell_es.setup({
      on_attach = on_attach,
      filetypes = { "ps1", "psm1", "psd1" },
      bundle_path = "~/.local/share/nvim/mason/packages/powershell-editor-services",
      settings = { powershell = { codeFormatting = { Preset = "OTBS" } } },
      init_options = {
        enableProfileLoading = false,
      },
    })

    -- Do not forget to use the on_attach function
    lspconfig.zls.setup({
      on_attach = on_attach,
      handlers = handlers,
      cmd = { "zls" },
      filetypes = { "zig", "zlr" },
      root_dir = lspconfig.util.root_pattern(".git", "build.zig", vim.fn.getcwd()),
    }) -- this put HERE - made 'zls' workk!

    -- this commented out code below - breaks command completion in vim COMMAND mode/prompt
    -- '/' cmdline setup
    -- local cmp = require("cmp")
    -- cmp.setup.cmdline("/", {
    --   mapping = cmp.mapping.preset.cmdline(),
    --   sources = {
    --     { name = "buffer" },
    --   },
    -- })
    --
    -- -- ':' cmdline setup
    -- cmp.setup.cmdline(":", {
    --   mapping = cmp.mapping.preset.cmdline(),
    --   sources = cmp.config.sources({
    --     { name = "path" },
    --   }, {
    --     {
    --       name = "cmdline",
    --       option = {
    --         ignore_cmds = { "Man", "!" },
    --       },
    --     },
    --   }),
    -- })
  end,
}
