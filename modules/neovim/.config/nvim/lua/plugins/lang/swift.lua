return {
  -- add to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "swift" })
      end
    end,
  },

  -- mason installation
  -- NOTE: Mason does not install SourceKit-LSP, so we need to install it manually

  -- setup lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "lsp-zero.nvim",
    },
    opts = {
      ensure_installed = { "sourcekit" },
      servers = {
        sourcekit = function()
          require("lspconfig").sourcekit.setup({})
        end,
      },
    },
  },
}
