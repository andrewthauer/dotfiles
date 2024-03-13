-- Format python conditionally with ruff_format if available, otherwise use isort and black.
local python_formatter = function(bufnr)
  if require("conform").get_formatter_info("ruff_format", bufnr).available then
    return { "ruff_format" }
  else
    return { "isort", "black" }
  end
end

return {
  -- Lightweight yet powerful formatter plugin for Neovim
  -- https://github.com/stevearc/conform.nvim
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofmt" },
        javascript = { { "prettierd", "prettier" } },
        lua = { "stylua" },
        python = python_formatter,
        sh = { "shfmt" },
        typescript = { { "prettierd", "prettier" } },
      },
      -- format_on_save
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
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
    end,
  },
}
