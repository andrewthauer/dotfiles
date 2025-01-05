return {
  -- add to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "yaml" },
    },
  },

  -- mason installation
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "yaml-language-server" },
    },
  },

  -- yaml schema support
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release is way too old
  },

  -- setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      ensure_installed = { "yamlls" },
      servers = {
        yamlls = {},
      },
    },
  },

  -- conform formatters
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local formatters_by_ft = {
        -- Use LSP for formatting
        -- ["yaml"] = "prettier",
      }

      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for ft, formatter in pairs(formatters_by_ft) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], formatter)
      end
    end,
  },
}
