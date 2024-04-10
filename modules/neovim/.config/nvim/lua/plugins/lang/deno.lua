return {
  -- add to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "javascript",
          "typescript",
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
      ensure_installed = { "denols" },
      servers = {
        denols = function()
          local keys = {
            {
              "<leader>co",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.organizeImports.ts" },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Organize Imports",
            },
            {
              "<leader>cR",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.removeUnused.ts" },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Remove Unused Imports",
            },
          }

          require("lspconfig").denols.setup({
            ---@diagnostic disable-next-line: unused-local
            on_attach = function(client, bufnr)
              require("util").keys.set({ keys = keys, buffer = bufnr })
            end,
          })
        end,
      },
    },
  },
}
