return {
  -- add to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "ruby" })
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
      ensure_installed = { "ruby_lsp", "solargraph" },
      servers = {
        ruby_lsp = function()
          require("lspconfig").ruby_lsp.setup({})
        end,
      },
    },
  },
}