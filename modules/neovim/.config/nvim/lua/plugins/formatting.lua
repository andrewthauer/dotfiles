return {
  -- Lightweight yet powerful formatter plugin for Neovim
  -- https://github.com/stevearc/conform.nvim
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    cmd = "ConformInfo",
    keys = {
      {
        -- { "<leader>cf", "<D-I>" },
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format Buffer",
      },
    },
    -- opts = function()
    --   local opts = {
    --     formatters_by_ft = {
    --       -- defined in lang/*.lua
    --     },
    --     formatters = {
    --       injected = {
    --         options = { ignore_errors = true },
    --       },
    --     },
    --     format_on_save = function(bufnr)
    --       -- Disable with a global or buffer-local variable
    --       if vim.g.autoformat_enabled or vim.b[bufnr].autoformat then
    --         return { timeout_ms = 500, lsp_fallback = true }
    --       end
    --     end,
    --     notify_on_error = true,
    --   }
    --   return opts
    -- end,
    opts = {
      formatters_by_ft = {
        -- defined in lang/*.lua
      },
      formatters = {
        injected = {
          options = { ignore_errors = true },
        },
      },
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.autoformat_enabled or vim.b[bufnr].autoformat then
          return { timeout_ms = 500, lsp_fallback = true }
        end
      end,
      notify_on_error = true,
    },
    init = function()
      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format({ async = true, lsp_fallback = true, range = range })
      end, { range = true })

      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! will disable auto formatting just for this buffer
          ---@diagnostic disable-next-line: inject-field
          vim.b.autoformat = false
        else
          vim.g.autoformat_enabled = false
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })

      vim.api.nvim_create_user_command("FormatEnable", function(args)
        if args.bang then
          -- FormatEnable! will enable auto formatting just for this buffer
          ---@diagnostic disable-next-line: inject-field
          vim.b.autoformat = true
        else
          vim.g.autoformat_enabled = true
        end
      end, {
        desc = "Re-enable autoformat-on-save",
        bang = true,
      })

      vim.api.nvim_create_user_command("FormatToggle", function(args)
        if args.bang then
          -- FormatDisable! will toggle auto formatting just for this buffer
          ---@diagnostic disable-next-line: inject-field
          vim.b.autoformat = not vim.b.autoformat or false
        else
          vim.g.autoformat_enabled = not vim.g.autoformat_enabled or false
        end
      end, {
        desc = "Toggle autoformat-on-save",
        bang = true,
      })
    end,
  },
}
