return {
  -- add to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "css", "html" },
    },
  },

  -- conform formatters
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local formatters_by_ft = {
        ["css"] = "prettier",
        ["html"] = "prettier",
      }

      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for ft, formatter in pairs(formatters_by_ft) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], formatter)
      end
    end,
  },
}
