return {
  -- add to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "bash" },
    },
  },

  -- mason installation
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "bash-language-server",
        "shellcheck",
        "shfmt",
      },
    },
  },

  -- setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      ensure_installed = { "bashls" },
      servers = { "bashls" },
    },
  },

  -- conform formatters
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        bash = { "shfmt" },
        sh = { "shfmt" },
      },
    },
  },

  -- linting
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      vim.list_extend(opts.linters_by_ft, {
        bash = { "shellcheck" },
        sh = { "shellcheck" },
      })
    end,
  },
}
