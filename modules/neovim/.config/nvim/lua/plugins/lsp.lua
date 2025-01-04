local M = {}

local plugin_spec = {
  -- add blink.compat
  -- https://github.com/Saghen/blink.compat
  {
    "saghen/blink.compat",
    version = "*",
    lazy = true,
    opts = {},
  },

  -- completions provided by blink
  -- https://cmp.saghen.dev/
  {
    "saghen/blink.cmp",
    version = "*",
    dependencies = {
      "rafamadriz/friendly-snippets", -- https://github.com/rafamadriz/friendly-snippets
      "hrsh7th/cmp-emoji", -- https://github.com/hrsh7th/cmp-emoji
    },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "super-tab",
        cmdline = {
          preset = "enter",
        },
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        accept = {
          -- Disable auto brackets (some LSPs may add auto brackets themselves anyway
          -- auto_brackets = { enabled = false },
        },
        list = {
          selection = "manual",
        },
        -- Menu style
        menu = {},
        -- Show documentation when selecting a completion item
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
        -- ghost_text = { enabled = true },
      },
      -- signature = { enabled = true }
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "emoji" },
        providers = {
          emoji = {
            name = "emoji",
            module = "blink.compat.source",
          },
        },
      },
    },
    opts_extend = { "sources.default" },
  },

  -- Neovim's LSP client with minimum effort
  -- https://lsp-zero.netlify.app
  -- https://github.com/VonHeikemen/lsp-zero.nvim
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v4.x",
  },

  -- configurations for nvim lsp
  -- https://github.com/neovim/nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "saghen/blink.cmp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      ensure_installed = {},
      inlay_hints = {
        enabled = false,
      },
      codelens = {
        enabled = true,
      },
    },
    keys = {},
    config = function(_, opts)
      local lsp_zero = require("lsp-zero")

      local lsp_attach = function(client, bufnr)
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

        -- lsp_zero.default_keymaps({ buffer = bufnr })
        local Util = require("util")
        Util.map_keys({ keys = M.get_keymaps(), buffer = bufnr })
      end

      -- configure lsp
      lsp_zero.extend_lspconfig({
        capabilities = require("blink.cmp").get_lsp_capabilities(),
        lsp_attach = lsp_attach,
        sign_text = { error = "✘", warn = "▲", hint = "⚑", info = "»" },
        float_border = "rounded",
      })

      -- setup mason to install language servers
      require("mason-lspconfig").setup({
        automatic_installation = true,
        ensure_installed = opts.ensure_installed,
        handlers = vim.tbl_extend("force", {
          function(server_name)
            require("lspconfig")[server_name].setup({})
          end,
        }, opts.servers),
      })

      -- avoid conflicts with ts_ls & denols
      if M.get_lsp_config("denols") and M.get_lsp_config("ts_ls") then
        local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
        -- M.disable_lsp("vtsls", is_deno)
        M.disable_lsp("ts_ls", is_deno)
        M.disable_lsp("denols", function(root_dir)
          return not is_deno(root_dir)
        end)
      end
    end,
  },
}

function M.get_keymaps()
  return {
    -- stylua: ignore start
    -- New neovim defaults not released (> 0.10)
    { "grn", vim.lsp.buf.rename, desc = "Rename symbol" },
    { "gra", vim.lsp.buf.code_action, desc = "LSP Code Action" },
    { "grr", vim.lsp.buf.references, desc = "LSP References" },
    { "<c-s>", vim.lsp.buf.signature_help, desc = "LSP Signature Help", mode = "i", has ="signitureHelp" },
    -- custom
    { "K", vim.lsp.buf.hover, desc = "Hover documentation" },
    { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
    { "<C-k>", vim.lsp.buf.signature_help, desc = "Signature Help", mode = "i", has = "signatureHelp" },
    { "gd", vim.lsp.buf.definition, desc = "Go to definition" },
    { "gD", vim.lsp.buf.declaration, desc = "Go to declaration" },
    { "<F2>", vim.lsp.buf.rename, desc = "Rename symbol" },
    { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action" },
    { "<leader>cL", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
    { "<leader>cU", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
    { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
    { "<leader>cI", "<cmd>LspInfo<cr>", desc = "LSP Info" },
    -- not used
    -- { "glh", vim.lsp.buf.document_highlight, desc = "LSP Document Highlight" },
    -- { "glf", vim.lsp.buf.format, desc = "LSP Format" },
    -- { "glI", vim.lsp.buf.implementation, desc = "LSP Implementation" },
    -- { "gli", vim.lsp.buf.incoming_calls, desc = "LSP Incoming Calls" },
    -- { "glo", vim.lsp.buf.outgoing_calls, desc = "LSP Outgoing Calls" },
    -- { "glr", vim.lsp.buf.references, desc = "LSP References" },
    -- { "glH", vim.lsp.buf.signature_help, desc = "LSP Signiture Help" },
    -- { "glt", vim.lsp.buf.type_definition, desc = "LSP Type Definition" },
    -- { "<F3>", "<cmd>vim.lsp.buf.format({async = true})<cr>", desc = "Format file" },
    -- { "<F3>", "<cmd>vim.lsp.buf.format({async = true})<cr>", "desc = Format selection", mode = "x" },
    -- { "<F4>", "<cmd>vim.lsp.buf.code_action()<cr>", desc = "Execute code action" },
    -- { "<F4>", "<cmd>vim.lsp.buf.range_code_action()<cr>", desc = "Execute code action", mode = "x" },
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

  lsp_config.document_config.on_new_config = util.add_hook_before(
    lsp_config.document_config.on_new_config,
    function(config, root_dir)
      if cond(root_dir, config) then
        config.enabled = false
      end
    end
  )
end

return plugin_spec
