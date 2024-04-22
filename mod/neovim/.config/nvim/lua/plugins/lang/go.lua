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

  -- setup lspconfig
  {
    "neovim/nvim-lspconfig",
    depdencies = {
      "lsp-zero.nvim",
    },
    opts = {
      ensure_installed = { "gopls" },
      servers = {
        -- gopls = function()
        --   require("lspconfig").gopls.setup({})
        -- end,
      },
    },
  },
}
