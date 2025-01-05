return {
  -- add to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "hcl", "terraform" },
    },
  },

  -- mason installation
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "terraform-ls", "tflint" },
    },
  },

  -- setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        terraformls = {},
      },
    },
  },

  -- formatting configuration
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["terraform"] = { "terraform_fmt" },
        ["tf"] = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
      },
    },
  },

  -- linting
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      vim.list_extend(opts.linters_by_ft, {
        tflint = { "tflint" },
      })
    end,
  },
}
