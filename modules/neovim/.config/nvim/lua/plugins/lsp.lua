local M = {}

local plugin_spec = {
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
        enabled = false,
      },
      codelens = {
        enabled = true,
      },
    },
    keys = {},
    ---@diagnostic disable-next-line: unused-local
    config = function(_, opts)
      local lsp_zero = require("lsp-zero")

      -- set sign icons
      lsp_zero.set_sign_icons({
        error = "✘",
        warn = "▲",
        hint = "⚑",
        info = "»",
      })

      ---@diagnostic disable-next-line: unused-local
      lsp_zero.on_attach(function(client, bufnr)
        -- enable inlay hints
        if opts.inlay_hints.enabled and vim.lsp.inlay_hint then
          if client.supports_method("textDocument/inlayHint") or client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end
        end

        -- code lens
        if opts.codelens.enabled and vim.lsp.codelens then
          if client.supports_method("textDocument/codeLens") or client.server_capabilities.codeLensProvider then
            vim.lsp.codelens.refresh({ bufnr = 0 })
            vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
              buffer = bufnr,
              callback = vim.lsp.codelens.refresh,
            })
          end
        end

        -- keymaps
        -- see :help lsp-zero-keybindings
        -- lsp_zero.default_keymaps({ buffer = bufnr })
        local Util = require("util")
        Util.map_keys({ keys = M.get_keymaps(), buffer = bufnr })
      end)

      if opts.inlay_hints.enabled then
        vim.lsp.inlay_hint.enable(true)
      end

      -- to learn how to use mason.nvim with lsp-zero
      -- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
      require("mason-lspconfig").setup({
        ensure_installed = opts.ensure_installed,
        handlers = vim.tbl_extend("force", {
          lsp_zero.default_setup,
        }, opts.servers),
      })

      -- avoid conflicts with ts_ls & tsserver
      if M.get_lsp_config("denols") and M.get_lsp_config("ts_ls") then
        local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
        M.disable_lsp("ts_ls", is_deno)
        M.disable_lsp("denols", function(root_dir)
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

function M.get_keymaps()
  return {
    -- stylua: ignore start
    --
    -- neovim native
    --
    -- { "gla", vim.lsp.buf.code_action, desc = "LSP Code Actions" },
    -- { "gld", vim.lsp.buf.declaration, desc = "LSP Declaration" },
    -- { "glD", vim.lsp.buf.definition, desc = "LSP Definition" },
    -- { "glh", vim.lsp.buf.document_highlight, desc = "LSP Document Highlight" },
    -- { "glf", vim.lsp.buf.format, desc = "LSP Format" },
    -- { "glI", vim.lsp.buf.implementation, desc = "LSP Implementation" },
    -- { "gli", vim.lsp.buf.incoming_calls, desc = "LSP Incoming Calls" },
    -- { "glo", vim.lsp.buf.outgoing_calls, desc = "LSP Outgoing Calls" },
    -- { "glr", vim.lsp.buf.references, desc = "LSP References" },
    -- { "glH", vim.lsp.buf.signature_help, desc = "LSP Signiture Help" },
    -- { "glt", vim.lsp.buf.type_definition, desc = "LSP Type Definition" },
    --
    -- New neovim defaults (>= 0.10)
    -- { "crn", vim.lsp.buf.rename, desc = "Rename" },
    -- { "crr", vim.lsp.buf.code_action, desc = "Code Action" },
    -- { "gr", vim.lsp.buf.references, desc = "References" },
    -- { "<C-R>", vim.lsp.buf.code_action, desc = "Code Action", mode = "v" },
    -- { "<C-S>", vim.lsp.buf.signature_help, desc = "Signature Help", mode = "i", has = "signatureHelp" },
    --
    -- custom
    --
    { "K", vim.lsp.buf.hover, desc = "Hover documentation" },
    { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
    { "<C-k>", vim.lsp.buf.signature_help, desc = "Signature Help", mode = "i", has = "signatureHelp" },
    { "gd", vim.lsp.buf.definition, desc = "Go to definition" },
    { "gD", vim.lsp.buf.declaration, desc = "Go to declaration" },
    -- { "gi", vim.lsp.buf.implementation, desc = "Go to implementation" },
    -- { "go", vim.lsp.buf.type_definition, desc = "Go to type definition" },
    -- { "gr", vim.lsp.buf.references, desc = "Go to reference" },
    -- { "gs", vim.lsp.buf.signature_help", desc = "Show function signature" },
    { "<F2>", vim.lsp.buf.rename, desc = "Rename symbol" },
    -- { "<F3>", "<cmd>vim.lsp.buf.format({async = true})<cr>", desc = "Format file" },
    -- { "<F3>", "<cmd>vim.lsp.buf.format({async = true})<cr>", "desc = Format selection", mode = "x" },
    -- { "<F4>", "<cmd>vim.lsp.buf.code_action()<cr>", desc = "Execute code action" },
    -- { "<F4>", "<cmd>vim.lsp.buf.range_code_action()<cr>", desc = "Execute code action", mode = "x" },
    -- { "gl", vim.diagnostic.open_float", "desc = Show diagnostic" },
    { "[d", vim.diagnostic.goto_prev, desc = "Previous diagnostic" },
    { "]d", vim.diagnostic.goto_next, desc = "Next diagnostic" },
    { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action" },
    { "<leader>cL", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
    { "<leader>cU", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
    { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
    { "<leader>cI", "<cmd>LspInfo<cr>", desc = "LSP Info" },
    --
    -- telescope helpers
    --
    { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References (Telescope)" },
    { "ds", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols (Telescope)" },
    { "<leader>cd", "<cmd>Telescope lsp_definitions<cr>", desc = "Definitions (Telescope)" },
    { "<leader>cD", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Type Definitions (Telescope)" },
    { "<leader>ci", "<cmd>Telescope lsp_implementations<cr>", desc = "Implementations (Telescope)" },
    { "<leader>cci", "<cmd>Telescope lsp_incoming_calls<cr>", desc = "Incoming Calls (Telescope)" },
    { "<leader>cco", "<cmd>Telescope lsp_outgoing_calls<cr>", desc = "Outgoing Calls (Telescope)" },
    { "<leader>cR", "<cmd>Telescope lsp_references<cr>", desc = "References (Telescope)" },
    { "<leader>cs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols (Telescope)" },
    { "<leader>ws", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "Workspace Symbols (Telescope)" },
    { "<leader>wS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols, Dynamic (Telescope)" },
    -- stylua: ignore end
  }
end

-- Get an lsp server configuration
function M.get_lsp_config(server)
  local configs = require("lspconfig.configs")
  return rawget(configs, server)
end

-- Disable an lsp server
function M.disable_lsp(server, cond)
  local util = require("lspconfig.util")
  local lsp_config = M.get_lsp_config(server)

  lsp_config.document_config.on_new_config = util.add_hook_before(lsp_config.document_config.on_new_config, function(config, root_dir)
    if cond(root_dir, config) then
      config.enabled = false
    end
  end)
end

return plugin_spec
