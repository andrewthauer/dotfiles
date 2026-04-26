return {
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
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        accept = {},
        list = {
          selection = { preselect = true, auto_insert = true },
        },
        menu = {},
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
      },
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
    dependencies = {
      "saghen/blink.cmp",
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    opts = {
      ensure_installed = {},
      servers = {},
    },
    config = function(_, opts)
      require("mason-lspconfig").setup({
        automatic_enable = true,
        ensure_installed = opts.ensure_installed,
      })

      for server, settings in pairs(opts.servers or {}) do
        if type(settings) == "function" then
          settings = settings()
        end
        vim.lsp.config(server, settings)
      end
    end,
  },
}
