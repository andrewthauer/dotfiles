return {
  -- add to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "bash",
        })
      end
    end,
  },

  -- mason installation
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "shellcheck",
        "shfmt",
      })
    end,
  },

  -- mason installation
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "lsp-zero.nvim" },
    opts = function(_, opts)
      local lsp_zero = require("lsp-zero")
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "bash-language-server",
      })
      opts.handlers = opts.handlers or {}
      vim.list_extend(opts.handlers, {
        -- disable for now
        bashls = lsp_zero.noop,
      })
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

  -- setup lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "lsp-zero.nvim",
    },
    opts = {
      ensure_installed = { "bash-language-server" },
    },
  },
}
