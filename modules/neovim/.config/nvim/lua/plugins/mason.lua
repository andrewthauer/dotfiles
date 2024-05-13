return {
  {
    -- Portable package manager for Neovim
    -- https://github.com/williamboman/mason.nvim
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
    },
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {})
    end,
    config = function(_, opts)
      require("mason").setup(opts)
      require("util").plugin.ensure_installed(opts)
    end,
  },
}
