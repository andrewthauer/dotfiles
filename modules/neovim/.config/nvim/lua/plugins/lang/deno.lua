return {
  -- add to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "javascript",
          "typescript",
        })
      end
    end,
  },

  -- mason installation
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "deno" })
    end,
  },

  -- setup lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "lsp-zero.nvim",
    },
    opts = {
      ensure_installed = { "denols" },
      servers = {
        denols = function()
          require("lspconfig").denols.setup({
            settings = {
              deno = {
                inlayHints = {
                  parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = true },
                  parameterTypes = { enabled = true },
                  variableTypes = { enabled = true, suppressWhenTypeMatchesName = true },
                  propertyDeclarationTypes = { enabled = true },
                  functionLikeReturnTypes = { enable = true },
                  enumMemberValues = { enabled = true },
                },
              },
            },
          })
        end,
      },
    },
  },
}
