return {
  -- add to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "gotmpl",
          "yaml",
        })
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
      ensure_installed = { "helm_ls" },
      servers = {
        -- helm_ls = function()
        --   require("lspconfig").helm_ls.setup({})
        -- end,
      },
    },
  },
}
