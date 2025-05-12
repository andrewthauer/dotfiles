return {
  -- add to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "javascript",
        "jsdoc",
        "typescript",
        "tsx",
      },
    },
  },

  -- mason installation
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "typescript-language-server",
        "prettier",
      },
    },
  },

  -- conform formatters
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
      },
    },
  },

  -- setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      ensure_installed = { "ts_ls" },
      servers = {
        ts_ls = function()
          local keys = {
            {
              "<leader>co",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    ---@diagnostic disable-next-line: assign-type-mismatch
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
                    ---@diagnostic disable-next-line: assign-type-mismatch
                    only = { "source.removeUnused.ts" },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Remove Unused Imports",
            },
          }

          local inlay_hints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
            importModuleSpecifierPreference = "non-relative",
          }

          return {
            on_attach = function(client, bufnr)
              require("util").map_keys({ keys = keys, buffer = bufnr })
            end,
            settings = {
              javascript = { inlayHints = inlay_hints },
              typescript = { inlayHints = inlay_hints },
              completions = {
                completeFunctionCalls = true,
              },
            },
          }
        end,
      },
    },
  },

  -- config debug adapter for node
  {
    "mfussenegger/nvim-dap",
    enbled = false,
    optional = true,
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          table.insert(opts.ensure_installed, "js-debug-adapter")
        end,
      },
      -- vscode-js-debug adapter
      {
        "microsoft/vscode-js-debug",
        build = "npm i && npm run compile vsDebugServerBundle && rm -rf out && mv -f dist out",
      },
      {
        "mxsdev/nvim-dap-vscode-js",
        opts = {
          debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),
          adapters = {
            "pwa-node",
            "pwa-chrome",
            "pwa-msedge",
            "node-terminal",
            "pwa-extensionHost",
          },
        },
      },
    },
    opts = function()
      local dap = require("dap")
      local js_based_languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
      -- if not dap.adapters["pwa-node"] then
      --   require("dap").adapters["pwa-node"] = {
      --     type = "server",
      --     host = "localhost",
      --     port = "${port}",
      --     executable = {
      --       command = "node",
      --       -- 💀 Make sure to update this path to point to your installation
      --       args = {
      --         require("mason-registry").get_package("js-debug-adapter"):get_install_path()
      --           .. "/js-debug/src/dapDebugServer.js",
      --         "${port}",
      --       },
      --     },
      --   }
      -- end
      for _, language in ipairs(js_based_languages) do
        if not dap.configurations[language] then
          dap.configurations[language] = {
            {
              name = "Launch file",
              type = "pwa-node",
              request = "launch",
              program = "${file}",
              cwd = "${workspaceFolder}",
              sourceMaps = true,
            },
            {
              name = "Attach",
              type = "pwa-node",
              request = "attach",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
              sourceMaps = true,
            },
            -- Divider for the launch.json derived configs
            {
              name = "----- ↓ launch.json configs ↓ -----",
              type = "",
              request = "launch",
            },
          }
        end
      end
    end,
  },
}
