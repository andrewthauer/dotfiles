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
      },
      -- cmdline = {
      --   keymap = {
      --     preset = "super-tab",
      --   },
      -- },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        accept = {
          -- Disable auto brackets (some LSPs may add auto brackets themselves anyway
          -- auto_brackets = { enabled = false },
        },
        list = {
          selection = { preselect = true, auto_insert = true },
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

  -- configurations for nvim lsp
  -- https://github.com/neovim/nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "saghen/blink.cmp",
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
      },
      ensure_installed = {},
      servers = {},
      inlay_hints = {
        enabled = false,
      },
      codelens = {
        enabled = true,
      },
    },
    config = function(_, opts)
      -- configure lsp on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local buffer = event.buf
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          M.lsp_attach(client, buffer, opts)
        end,
      })

      -- configure diatnostics
      vim.diagnostic.config(opts.diagnostics)

      -- auto setup lsp servers
      require("mason-lspconfig").setup({
        automatic_enable = true,
        ensure_installed = opts.ensure_installed,
      })

      -- configure and enable lsp servers
      local servers = opts.servers or {}
      for server, settings in pairs(servers) do
        if type(settings) == "function" then
          settings = settings()
        end
        vim.lsp.config(server, settings)
        vim.lsp.enable(server)
      end
    end,
  },
}

function M.get_keymaps()
  return {
    -- stylua: ignore start
    { "g.", vim.lsp.buf.code_action, desc = "Code Action" },
    { "<F2>", vim.lsp.buf.rename, desc = "Rename symbol" },
    { "<leader>cL", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
    { "<leader>cU", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
    { "<leader>cI", "<cmd>LspInfo<cr>", desc = "LSP Info" },
    -- stylua: ignore end
  }
end

-- attach function for lsp
-- -- @param client lsp client
-- -- @param bufnr buffer number
function M.lsp_attach(client, bufnr, opts)
  -- enable inlay hints
  if opts.inlay_hints.enabled then
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

  -- key mappings
  local Util = require("util")
  Util.map_keys({ keys = M.get_keymaps(), buffer = bufnr })

  -- avoid conflicts with ts_ls & denols
  local lspconfig = require("lspconfig")
  local is_in_deno_repo = lspconfig.util.root_pattern("deno.json", "deno.jsonc")(vim.fn.getcwd())
  if is_in_deno_repo then
    if client.name == "ts_ls" then
      client.stop()
    end
  else
    if client.name == "denols" then
      client.stop()
    end
  end
end

return plugin_spec
