return {
  -- add to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "javascript", "typescript" },
    },
  },

  -- mason installation
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "deno" },
    },
  },

  -- setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      ensure_installed = { "denols" },
      servers = {
        denols = {
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
        },
      },
    },
  },
}
