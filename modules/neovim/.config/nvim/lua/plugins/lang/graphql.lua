return {
  -- add to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "graphql" },
    },
  },

  -- mason installation
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "prettier" },
    },
  },

  -- conform formatters
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        graphql = { "prettier" },
      },
    },
  },
}
