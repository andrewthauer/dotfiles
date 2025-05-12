return {
  -- add to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "go",
        "gomod",
        "gosum",
        "gotmpl",
      },
    },
  },

  -- mason installation
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "gopls" },
    },
  },

  -- conform formatters
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        go = { "gofmt" },
        gomod = { "gofmt" },
        gosum = { "gofmt" },
        gotmpl = { "gofmt" },
      },
    },
  },

  -- setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      ensure_installed = { "gopls" },
      servers = {
        gopls = {
          settings = {
            gopls = {
              hints = {
                rangeVariableTypes = true,
                parameterNames = true,
                constantValues = true,
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                functionTypeParameters = true,
              },
            },
          },
        },
      },
    },
  },
}
