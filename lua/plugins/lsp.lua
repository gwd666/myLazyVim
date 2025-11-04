-- trying to remap lsp signature_help from C-k to C-o
return {
  "neovim/nvim-lspconfig",
  dependencies = { "saghen/blink.cmp" },

  opts = {
    setup = {
      rust_analyzer = function()
        return true
      end,
    },
  },

  init = function()
    local lsp_keymap_group = vim.api.nvim_create_augroup("custom_lsp_insert_mappings", { clear = true })
    -- Override LazyVim's LspAttach to remove C-k and add C-o for signature help
    vim.api.nvim_create_autocmd("LspAttach", {
      group = lsp_keymap_group,
      callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- Remove C-k signature help if it was set by LazyVim
        pcall(vim.keymap.del, "i", "<C-k>", { buffer = bufnr })

        -- Always map <C-k> to move the cursor up in insert mode on LSP buffers
        vim.keymap.set("i", "<C-k>", "<Up>", { buffer = bufnr, noremap = true, silent = true, desc = "Move cursor up" })

        -- Set C-o for signature help if client supports it
        if client and client.server_capabilities.signatureHelpProvider then
          vim.keymap.set("i", "<C-o>", function()
            vim.lsp.buf.signature_help()
          end, { buffer = bufnr, noremap = true, silent = true, desc = "LSP Signature Help" })
        end
      end,
    })

    -- Note: C-o mapping for signature help is handled above
    lspconfig = require("lspconfig")
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

  keys = {
    -- Disable LazyVim's default <C-k> signature help mapping late so it does not get overruled by other lsp config before this block
    { "<C-k>", false, mode = "i" },
    -- Map signature help to <C-o> instead
    {
      "<C-o>",
      function()
        vim.lsp.buf.signature_help()
      end,
      mode = "i",
      desc = "LSP Signature Help",
    },
  },
}
