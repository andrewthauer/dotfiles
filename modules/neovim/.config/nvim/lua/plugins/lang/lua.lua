return {
  -- add to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "lua" },
    },
  },

  -- mason installation
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
      },
    },
  },

  -- lazydev.nvim
  -- https://github.com/folke/lazydev.nvim
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  -- setup lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
    },
    opts = {
      ensure_installed = { "lua_ls" },
      servers = {
        lua_ls = {},
      },
    },
  },

  -- conform formatters
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
  },
}
