return {
  -- add to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "lua" })
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
      ensure_installed = { "tsserver" },
      servers = {
        lua_ls = function()
          local lsp_zero = require("lsp-zero")
          local lua_opts = lsp_zero.nvim_lua_ls()
          require("lspconfig").lua_ls.setup(lua_opts)
        end,
      },
    },
  },
}
