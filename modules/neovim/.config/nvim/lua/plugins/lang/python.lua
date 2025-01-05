return {
  -- add to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "python" },
    },
  },

  -- mason installation
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "pyright" },
    },
  },

  -- setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      ensure_installed = { "pyright" },
      servers = {
        pyright = {},
      },
    },
  },
}
