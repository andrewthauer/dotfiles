local function get_keymaps()
  return {
    --
    -- neovim native
    --
    -- vim.lsp.codelens
    -- vim.lsp.buf.code_action
    -- vim.lsp.buf.declaration
    -- vim.lsp.buf.definition
    -- vim.lsp.buf.document_highlight
    -- vim.lsp.buf.format
    -- vim.lsp.buf.hover
    -- vim.lsp.buf.implementation
    -- vim.lsp.buf.incoming_calls
    -- vim.lsp.buf.outgoing_calls
    -- vim.lsp.buf.references
    -- vim.lsp.buf.references
    -- vim.lsp.buf.signature_help
    -- vim.lsp.buf.type_definition
    --
    -- New neovim defaults (>= 0.10)
    { "crn", vim.lsp.buf.rename, desc = "Rename" },
    { "crr", vim.lsp.buf.code_action, desc = "Code Action" },
    -- { "gr", vim.lsp.buf.references, desc = "References" },
    { "<C-R>", vim.lsp.buf.code_action, desc = "Code Action", mode = "v" },
    { "<C-S>", vim.lsp.buf.signature_help, desc = "Signature Help", mode = "i", has = "signatureHelp" },
    --
    -- From lsp-zero
    --
    -- { "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename symbol" },
    -- { "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", desc = "Format file" },
    -- { "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", desc = "Format selection", mode = "x" },
    -- { "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Execute code action" },
    -- { "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", "Show diagnostic" },
    -- { "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Previous diagnostic" },
    -- { "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next diagnostic" },
    --
    -- custom
    --
    -- Opens a popup that displays documentation about the word under your cursor
    --   See `:help K` for why this keymap.
    { "K", vim.lsp.buf.hover, desc = "Hover Documentation" },
    -- Show the signature help for the word under your cursor.
    --   <cmd>lua vim.lsp.buf.signature_help()<cr>
    { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
    -- Show the signature help for the word under your cursor (insert mode).
    --   <cmd>lua vim.lsp.buf.signature_help()<cr>
    { "<C-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    --    <cmd>lua vim.lsp.buf.declaration()<cr>
    { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action" },
    -- Execute a codelens action
    { "<leader>cl", vim.lsp.codelens.run, desc = "Run Codelens", mode = "v", has = "codeLens" },
    -- Most Language Servers support renaming across files, etc.
    -- Rename the variable under your cursor.
    { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
    -- Show the LSP info for the current buffer.
    { "<leader>ci", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
    --
    -- telescope helpers
    --
    { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
    { "ds", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
    { "<leader>ws", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols" },
    { "<leader>wS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols (Dynamic)" },
    { "<leader>cci", "<cmd>Telescope lsp_incoming_calls<cr>", desc = "Incoming Calls" },
    { "<leader>cco", "<cmd>Telescope lsp_outgoing_calls<cr>", desc = "Outgoing Calls" },
    { "<leader>ctd", "<cmd>Telescope lsp_definitions<cr>", desc = "Goto Definition" },
    { "<leader>ctD", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Type Definition" },
  }
end

return {
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
      inlay_hints = {
        enabled = true,
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
        local Util = require("util")
        Util.lsp.on_attach(client, bufnr, opts)
        Util.map_keys({ keys = get_keymaps(), buffer = bufnr })
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
    dependencies = {
      "nvim-cmp",
      ---@diagnostic disable-next-line: unused-local
      opts = function(_, opts)
        ---@diagnostic disable-next-line: unused-local
        -- local cmp_action = require("lsp-zero").cmp_action()
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
