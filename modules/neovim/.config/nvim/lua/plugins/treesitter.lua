return {
  -- synatx highlighting, etc.
  -- https://github.com/nvim-treesitter/nvim-treesitter
  -- https://github.com/tree-sitter/tree-sitter
  --
  -- There are additional nvim-treesitter modules that you can use to interact with nvim-treesitter.
  --
  --   - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --   - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --   - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts_extend = { "ensure_installed" },
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true,
      sync_install = false,
      ensure_installed = {
        "csv",
        "diff",
        "editorconfig",
        "ini",
        "lua",
        "make",
        "perl",
        "php",
        "properties",
        "query",
        "regex",
        "ssh_config",
        "tsv",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
          },
          selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
            ["@class.outer"] = "<c-v>", -- blockwise
          },
          include_surrounding_whitespace = true,
        },
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
        },
      },
    },
    ---@param opts TSConfig
    config = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      if type(opts.ensure_installed) == "table" then
        ---@diagnostic disable-next-line: param-type-mismatch
        opts.ensure_installed = require("util").table.dedupe(opts.ensure_installed)
      end
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  -- treesitter text objects
  -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },

  -- rainbow delimiters
  -- https://github.com/HiPhish/rainbow-delimiters.nvim
  {
    "HiPhish/rainbow-delimiters.nvim",
    config = function()
      require("rainbow-delimiters.setup").setup({})
    end,
  },
}
