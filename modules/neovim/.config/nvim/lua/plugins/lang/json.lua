return {
  -- add to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "json",
        "jsonc",
        "json5",
      },
    },
  },

  -- mason installation
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "json-lsp" },
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
      ensure_installed = { "json-lsp" },
      servers = {
        jsonls = {},
      },
    },
  },

  -- conform formatters
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        json = { "prettier" },
        jsonc = { "prettier" },
        json5 = { "prettier" },
      },
    },
  },
}
