return {
  -- add to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "markdown", "markdown_inline" },
    },
  },

  -- mason installation
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- "marksman",
      },
    },
  },

  -- setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      ensure_installed = {
        -- "marksman",
      },
      servers = {
        -- marksman = function()
        --   require("lspconfig").marksman.setup({})
        -- end,
      },
    },
  },

  -- conform formatters
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      local formatters_by_ft = {
        ["markdown"] = "prettier",
        ["markdown.mdx"] = "prettier",
      }

      opts.formatters_by_ft = opts.formatters_by_ft or {}
      for ft, formatter in pairs(formatters_by_ft) do
        opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
        table.insert(opts.formatters_by_ft[ft], formatter)
      end
    end,
  },

  -- markdown preview
  -- https://github.com/iamcco/markdown-preview.nvim
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}
