return {
  -- Neovim's LSP client with minimum effort
  -- https://lsp-zero.netlify.app
  -- https://github.com/VonHeikemen/lsp-zero.nvim
  { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },

  -- configurations for nvim lsp
  -- https://github.com/neovim/nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
    },
    opts = {
      servers = {
        denols = {},
      },
    },
    config = function(_, opts)
      local lsp_zero = require("lsp-zero") ---@diagnostic disable-next-line: unused-local
      lsp_zero.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp_zero.default_keymaps({ buffer = bufnr })
      end)

      -- to learn how to use mason.nvim with lsp-zero
      -- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
      -- require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = {
          "docker_compose_language_service",
          "dockerls",
          "denols",
          "gopls",
          "helm_ls",
          "jsonls",
          "lua_ls",
          "marksman",
          "pyright",
          "ruby_ls",
          "rust_analyzer",
          "taplo", -- toml
          "tsserver",
          "yamlls",
        },
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
          end,
        },
      })
    end,
  },
}
