return {
  -- add to treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "markdown",
        "markdown_inline",
      },
    },
  },

  -- mason installation
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- "marksman",
        "prettier",
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
    opts = {
      formatters_by_ft = {
        markdown = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
      },
    },
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
