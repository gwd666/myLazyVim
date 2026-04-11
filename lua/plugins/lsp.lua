return {
  "neovim/nvim-lspconfig",
  dependencies = { "saghen/blink.cmp" },

  init = function()
    vim.api.nvim_create_user_command("LspHealth", function()
      vim.cmd("checkhealth vim.lsp")
    end, { desc = "Check Neovim LSP health" })

    vim.api.nvim_create_user_command("LspLog", function()
      vim.cmd("tabnew " .. vim.lsp.log.get_filename())
    end, { desc = "Open Neovim LSP log" })

    vim.api.nvim_create_user_command("LspAttached", function()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      local names = vim.tbl_map(function(client)
        return client.name
      end, clients)

      if #names == 0 then
        vim.notify("No LSP clients attached to current buffer", vim.log.levels.INFO, { title = "LspAttached" })
        return
      end

      vim.notify(table.concat(names, ", "), vim.log.levels.INFO, { title = "LspAttached" })
    end, { desc = "Show LSP clients attached to current buffer" })

    local lsp_keymap_group = vim.api.nvim_create_augroup("custom_lsp_insert_mappings", { clear = true })
    vim.api.nvim_create_autocmd("LspAttach", {
      group = lsp_keymap_group,
      callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        pcall(vim.keymap.del, "i", "<C-k>", { buffer = bufnr })
        vim.keymap.set("i", "<C-k>", "<Up>", { buffer = bufnr, noremap = true, silent = true, desc = "Move cursor up" })

        if client and client.server_capabilities.signatureHelpProvider then
          vim.keymap.set("i", "<C-o>", function()
            vim.lsp.buf.signature_help()
          end, { buffer = bufnr, noremap = true, silent = true, desc = "LSP Signature Help" })
        end
      end,
    })

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

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = border,
      max_width = 80,
      max_height = 20,
      relative = "cursor",
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = border,
    })
  end,

  opts = function(_, opts)
    opts = opts or {}
    opts.servers = opts.servers or {}
    opts.setup = opts.setup or {}

    local julia = "julia"
    local juliaup_bins = vim.fn.glob(vim.fn.expand("~/.julia/juliaup/*/bin/julia.exe"), false, true)
    if #juliaup_bins > 0 then
      table.sort(juliaup_bins)
      julia = juliaup_bins[#juliaup_bins]
    else
      local julia_exepath = vim.fn.exepath("julia")
      if julia_exepath ~= "" then
        julia = julia_exepath
      end
    end

    opts.servers.ocamllsp = {
      mason = false,
    }
    opts.servers.julials = {
      mason = false,
      cmd = {
        julia,
        "--project=" .. vim.fn.expand("~/.julia/environments/nvim-lspconfig"),
        "--startup-file=no",
        "--history-file=no",
        "-e",
        [[
          using LanguageServer, SymbolServer, StaticLint
          depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
          project_path = let
              dirname(something(
                  Base.load_path_expand((
                      p = get(ENV, "JULIA_PROJECT", nothing);
                      p === nothing ? nothing : isempty(p) ? nothing : p
                  )),
                  Base.current_project(),
                  get(Base.load_path(), 1, nothing),
                  Base.load_path_expand("@v#.#"),
              ))
          end
          @info "Running language server" VERSION pwd() project_path depot_path
          server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)
          server.runlinter = true
          run(server)
        ]],
      },
      filetypes = {
        "julia",
        "juliamarkdown",
        "juliamarkdown.pandoc",
        "juliamarkdown.latex",
        "juliamarkdown.html",
      },
    }
    opts.servers.lua_ls = {
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if
            path ~= vim.fn.stdpath("config")
            and (
              (vim.uv or vim.loop).fs_stat(path .. "/.luarc.json")
              or (vim.uv or vim.loop).fs_stat(path .. "/.luarc.jsonc")
            )
          then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
          runtime = {
            version = "LuaJIT",
          },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
            },
          },
        })
      end,
      settings = {
        Lua = {},
      },
    }
    opts.setup.julials = function(_, server_opts)
      vim.lsp.config("julials", server_opts)
      vim.lsp.enable("julials")
      return true
    end
    opts.setup.rust_analyzer = function()
      return true
    end

    return opts
  end,

  keys = {
    { "<C-k>", false, mode = "i" },
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
