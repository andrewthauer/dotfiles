local M = {}

M.plugin_spec = {
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
        "jsonls",
        "lua_ls",
        "taplo", -- toml
        "yamlls",
      },
    },
    keys = {},
    ---@diagnostic disable-next-line: unused-local
    config = function(_, opts)
      local lsp_zero = require("lsp-zero")
      local lsp_util = require("util.lsp")

      -- set sign icons
      lsp_zero.set_sign_icons({
        error = "✘",
        warn = "▲",
        hint = "⚑",
        info = "»",
      })

      ---@diagnostic disable-next-line: unused-local
      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        lsp_zero.default_keymaps({ buffer = bufnr })
        -- custom key maps
        require("util").keys.set({ keys = M.get_keymaps(), buffer = bufnr })
      end)

      -- to learn how to use mason.nvim with lsp-zero
      -- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
      require("mason-lspconfig").setup({
        ensure_installed = opts.ensure_installed,
        handlers = vim.tbl_extend("force", {
          lsp_zero.default_setup,
        }, opts.servers),
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

function M.get_keymaps()
  return {
    --
    -- From lsp-zero
    --
    -- { "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename symbol" },
    -- { "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", desc = "Format file" },
    -- { "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", desc = "Format selection", mode = "x" },
    -- { "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Execute code action" },
    -- if vim.lsp.buf.range_code_action then
    --   map('<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>', 'Execute code action')
    -- else
    --   map('<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Execute code action')
    -- end
    -- { "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", "Show diagnostic" },
    -- { "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Previous diagnostic" },
    -- { "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next diagnostic" },
    --
    -- custom
    --
    -- Opens a popup that displays documentation about the word under your cursor
    --  See `:help K` for why this keymap.
    { "K", vim.lsp.buf.hover, desc = "Hover Documentation" },

    -- Show the signature help for the word under your cursor.
    { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },

    -- Show the signature help for the word under your cursor (insert mode).
    { "<C-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },

    -- Jump to the definition of the word under your cursor.
    --  This is where a variable was first declared, or where a function is defined, etc.
    --  To jump back, press <C-t>.
    --    <cmd>lua vim.lsp.buf.declaration()
    { "gd", require("telescope.builtin").lsp_definitions, desc = "Goto Definition" },

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    --    <cmd>lua vim.lsp.buf.declaration()<cr>
    { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },

    -- Jump to the implementation of the word under your cursor.
    --  Useful when your language has ways of declaring types without an actual implementation.
    --    <cmd>lua vim.lsp.buf.implementation()<cr>
    { "gI", require("telescope.builtin").lsp_implementations, desc = "Goto Implementation" },

    -- Jump to the type of the word under your cursor.
    --  Useful when you're not sure what type a variable is and you want to see
    --  the definition of its *type*, not where it was *defined*.
    --    <cmd>lua vim.lsp.buf.type_definition()<cr>
    { "go", require("telescope.builtin").lsp_type_definitions, desc = "Type Definition" },

    -- Find references for the word under your cursor.
    --   <cmd>lua vim.lsp.buf.references()<cr>
    { "gr", require("telescope.builtin").lsp_references, desc = "Goto References" },

    -- Shwo signature help for the word under your cursor.
    -- <cmd>lua vim.lsp.buf.signature_help()<cr>
    { "gs", vim.lsp.buf.signature_help, desc = "Signiture Function Help" },

    -- Fuzzy find all the symbols in your current document.
    --  Symbols are things like variables, functions, types, etc.
    { "<leader>ds", require("telescope.builtin").lsp_document_symbols, desc = "Document Symbols" },

    -- Fuzzy find all the symbols in your current workspace.
    --  Similar to document symbols, except searches over your entire project.
    { "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, desc = "Workspace Symbols" },

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action" },

    -- Execute a codelens action
    { "<leader>cl", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "v" }, has = "codeLens" },

    -- Show the LSP info for the current buffer.
    { "<leader>ci", "<cmd>LspInfo<cr>", desc = "Lsp Info" },

    -- Rename the variable under your cursor.
    --  Most Language Servers support renaming across files, etc.
    { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
  }
end

return M.plugin_spec
