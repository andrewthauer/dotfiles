return {
  -- add to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "ruby" },
    },
  },

  -- mason installation
  {
    "mason-org/mason.nvim",
    opts = {
      -- ensure_installed = { "rubocop", "ruby-lsp" },
    },
  },

  -- setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- ensure_installed = { "ruby_lsp", "solargraph" },
      servers = {
        -- ruby_lsp = {},
      },
    },
  },

  -- linting
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      vim.list_extend(opts.linters_by_ft, {
        -- ruby = { "rubocop" },
      })
    end,
  },
}
