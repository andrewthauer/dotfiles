return {
  -- add to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "rust" },
    },
  },

  -- mason installation
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "rust-analyzer" },
    },
  },

  -- setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      ensure_installed = { "rust_analyzer" },
      servers = {
        rust_analyzer = {
          settings = {
            inlayHints = {
              bindingModeHints = { enable = false },
              chainingHints = { enable = true },
              closingBraceHints = { enable = true, minLines = 25 },
              closureReturnTypeHints = { enable = "never" },
              lifetimeElisionHints = { enable = "never", useParameterNames = false },
              maxLength = 25,
              parameterHints = { enable = true },
              reborrowHints = { enable = "never" },
              renderColons = true,
              typeHints = {
                enable = true,
                hideClosureInitialization = false,
                hideNamedConstructor = false,
              },
            },
          },
        },
      },
    },
  },
}
