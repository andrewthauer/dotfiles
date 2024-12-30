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
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      auto_install = true,
      sync_install = true,
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "csv",
        "cue",
        "diff",
        "dockerfile",
        "editorconfig",
        "fish",
        "git_config",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "go",
        "gotmpl",
        "graphql",
        "hcl",
        "helm",
        "html",
        "ini",
        "java",
        "javascript",
        "jq",
        "jsdoc",
        "json",
        "json5",
        "jsonc",
        "just",
        "kotlin",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "mermaid",
        "nix",
        "nu",
        "perl",
        "php",
        "properties",
        "python",
        "query",
        "regex",
        "ruby",
        "rust",
        "sql",
        "ssh_config",
        "swift",
        "terraform",
        "toml",
        "tsv",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
        "zig",
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
    config = function(_, opts)
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
