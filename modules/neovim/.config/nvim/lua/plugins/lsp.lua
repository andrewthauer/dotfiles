local M = {}

M.lsp_plugin_spec = {
  -- configurations for nvim lsp
  -- https://github.com/neovim/nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
      { "folke/neodev.nvim", opts = {} },
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
    },
    opts = {
      ensure_installed = {
        "docker_compose_language_service",
        "dockerls",
        "denols",
        "gopls",
        "helm_ls",
        -- "jsonls",
        "lua_ls",
        "marksman",
        "pyright",
        "ruby_ls",
        "rust_analyzer",
        "solargraph",
        -- "taplo", -- toml
        "tsserver",
        "yamlls",
      },
    },
    keys = {},
    ---@diagnostic disable-next-line: unused-local
    config = function(_, opts)
      local lsp_zero = require("lsp-zero")
      local lsp_util = require("util.lsp")

      ---@diagnostic disable-next-line: unused-local
      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        lsp_zero.default_keymaps({ buffer = bufnr })
        -- custom key maps
        lsp_util.set_keymaps(M.get_lsp_keymaps())
      end)

      -- format on save
      -- lsp_zero.format_on_save({
      --   format_opts = {
      --     async = false,
      --     timeout_ms = 10000,
      --   },
      --   servers = {
      --     ["tsserver"] = { "javascript", "typescript" },
      --     ["rust_analyzer"] = { "rust" },
      --   },
      -- })

      -- to learn how to use mason.nvim with lsp-zero
      -- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
      -- require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = opts.ensure_installed,
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
          end,
        },
      })

      -- avoid conflicts with denols & tsserver
      if lsp_util.get_config("denols") and lsp_util.get_config("tsserver") then
        local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
        lsp_util.disable("tsserver", is_deno)
        lsp_util.disable("denols", function(root_dir)
          return not is_deno(root_dir)
        end)
      end
    end,
  },

  -- Neovim's LSP client with minimum effort
  -- https://lsp-zero.netlify.app
  -- https://github.com/VonHeikemen/lsp-zero.nvim
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    dependenciens = {
      "nvim-cmp",
      ---@diagnostic disable-next-line: unused-local
      opts = function(_, opts)
        ---@diagnostic disable-next-line: unused-local
        local cmp_action = require("lsp-zero").cmp_action()
        -- local mapping = {
        --   -- basic completions for Neovim's lua api
        --   ["<C-f>"] = cmp_action.luasnip_jump_forward(),
        --   ["<C-b>"] = cmp_action.luasnip_jump_backward(),
        --   -- enable SuperTab
        --   ["<Tab>"] = cmp_action.luasnip_supertab(),
        --   ["<S-Tab>"] = cmp_action.luasnip_shift_supertab(),
        --   -- regular tab
        --   -- ["<Tab>"] = cmp_action.tab_complete(),
        --   -- ["<S-Tab>"] = cmp_action.select_prev_or_fallback(),
        -- }
        -- for _, key in ipairs(mapping) do
        --   table.insert(opts.mapping, key)
        -- end
      end,
    },
  },
}

function M.get_lsp_keymaps()
  return {
    --
    -- From lsp-zero
    --
    { "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename symbol" } },
    -- { "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", { desc = "Format file" } },
    -- { "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", { desc = "Format selection", mode = "x" } },
    { "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", { desc = "Execute code action" } },
    -- if vim.lsp.buf.range_code_action then
    --   map('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>', 'Execute code action')
    -- else
    --   map('x', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Execute code action')
    -- end
    -- map('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', 'Show diagnostic')
    -- map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', 'Previous diagnostic')
    -- map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', 'Next diagnostic')
    --
    -- custom
    --
    -- Opens a popup that displays documentation about the word under your cursor
    --  See `:help K` for why this keymap.
    { "K", vim.lsp.buf.hover, { desc = "Hover Documentation" } },

    -- Show the signature help for the word under your cursor.
    { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },

    -- Show the signature help for the word under your cursor (insert mode).
    { "<C-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },

    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-t>.
    --    <cmd>lua vim.lsp.buf.declaration()
    { "gd", require("telescope.builtin").lsp_definitions, { desc = "[G]oto [D]efinition" } },

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    --    <cmd>lua vim.lsp.buf.declaration()<cr>
    { "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" } },

    -- Jump to the implementation of the word under your cursor.
    --  Useful when your language has ways of declaring types without an actual implementation.
    --    <cmd>lua vim.lsp.buf.implementation()<cr>
    { "gI", require("telescope.builtin").lsp_implementations, { desc = "[G]oto [I]mplementation" } },

    -- Jump to the type of the word under your cursor.
    --  Useful when you're not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    --    <cmd>lua vim.lsp.buf.type_definition()<cr>
    { "go", require("telescope.builtin").lsp_type_definitions, { desc = "Type [D]efinition" } },

    -- Find references for the word under your cursor.
    --   <cmd>lua vim.lsp.buf.references()<cr>
    { "gr", require("telescope.builtin").lsp_references, { desc = "[G]oto [R]eferences" } },

    -- Shwo signature help for the word under your cursor.
    -- <cmd>lua vim.lsp.buf.signature_help()<cr>
    { "gs", vim.lsp.buf.signature_help, { desc = "Signiture Function Help" } },

    -- Fuzzy find all the symbols in your current document.
    --  Symbols are things like variables, functions, types, etc.
    { "<leader>ds", require("telescope.builtin").lsp_document_symbols, { desc = "[D]ocument [S]ymbols" } },

    -- Fuzzy find all the symbols in your current workspace.
    --  Similar to document symbols, except searches over your entire project.
    { "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, { desc = "[W]orkspace [S]ymbols" } },

    -- Rename the variable under your cursor.
    --  Most Language Servers support renaming across files, etc.
    { "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" } },

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    { "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" } },

    -- Execute a codelens action
    { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },

    -- Show the LSP info for the current buffer.
    { "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
  }
end

return M.lsp_plugin_spec
