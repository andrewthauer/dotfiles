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

  -- helm syntax & filetype detection (required for helm_ls)
  -- https://github.com/towolf/vim-helm
  {
    "towolf/vim-helm",
    event = "VeryLazy",
    ft = "helm",
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
        helm_ls = function()
          require("lspconfig").helm_ls.setup({
            settings = {
              ["helm-ls"] = {
                yamlls = {
                  path = "yaml-language-server",
                },
              },
            },
          })
        end,
      },
    },
  },
}
