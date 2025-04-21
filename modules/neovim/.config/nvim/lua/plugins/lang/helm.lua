return {
  -- add to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "gotmpl", "yaml" },
    },
  },

  -- helm syntax & filetype detection (required for helm_ls)
  -- https://github.com/towolf/vim-helm
  {
    "towolf/vim-helm",
    event = "VeryLazy",
    ft = "helm",
  },

  -- mason installation
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = { "yamllint" },
    },
  },

  -- setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      ensure_installed = { "helm_ls" },
      servers = {
        helm_ls = {
          settings = {
            ["helm-ls"] = {
              yamlls = {
                path = "yaml-language-server",
              },
            },
          },
        },
      },
    },
  },
}
