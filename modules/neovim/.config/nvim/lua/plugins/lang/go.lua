return {
  -- add to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "go" })
      end
    end,
  },

  -- mason installation
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "gopls" })
    end,
  },

  -- setup lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "lsp-zero.nvim",
    },
    opts = {
      ensure_installed = { "gopls" },
      servers = {
        gopls = function()
          require("lspconfig").gopls.setup({
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
          })
        end,
      },
    },
  },
}
