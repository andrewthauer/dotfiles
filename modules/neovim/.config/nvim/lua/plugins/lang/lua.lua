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
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "lua-language-server", "stylua" },
    },
  },

  -- setup lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "folke/neodev.nvim", opts = {} },
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
    },
    opts = {
      ensure_installed = { "lua_ls" },
      servers = {
        lua_ls = function()
          local runtime_path = vim.split(package.path, ";")
          table.insert(runtime_path, "lua/?.lua")
          table.insert(runtime_path, "lua/?/init.lua")

          require("lspconfig").lua_ls.setup({
            settings = {
              Lua = {
                runtime = {
                  version = "LuaJIT",
                  path = runtime_path,
                },
                workspace = {
                  checkThirdParty = false,
                  library = {
                    vim.env.VIMRUNTIME,
                    "${3rd}/luv/library",
                    -- "${3rd}/busted/library",
                  },
                },
                diagnostics = {
                  globals = { "vim" },
                },
                hint = { enable = true },
              },
            },
          })
        end,
      },
    },
  },

  -- conform formatters
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local formatters_by_ft = {
        ["lua"] = "stylua",
      }

      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for ft, formatter in pairs(formatters_by_ft) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], formatter)
      end
    end,
  },
}
