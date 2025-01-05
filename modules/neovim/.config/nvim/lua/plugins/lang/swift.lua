return {
  -- add to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "swift" },
    },
  },

  -- mason installation
  -- NOTE: Mason does not install SourceKit-LSP, so we need to install it manually

  -- setup lspconfig
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     ensure_installed = { "sourcekit" },
  --     servers = {
  --       sourcekit = function()
  --         require("lspconfig").sourcekit.setup({})
  --       end,
  --     },
  --   },
  -- },
}
