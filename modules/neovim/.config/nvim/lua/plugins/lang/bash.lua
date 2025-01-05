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
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "bash-language-server", "shellcheck", "shfmt" },
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
    opts = function(_, opts)
      local formatters_by_ft = {
        ["bash"] = "shfmt",
        ["sh"] = "shfmt",
      }

      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for ft, formatter in pairs(formatters_by_ft) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], formatter)
      end

      -- opts.formatters = opts.formatters or {}
      -- opts.formatters.shfmt = {
      --   prepend_args = { "-i", "2", "-ci" },
      -- }
    end,
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
