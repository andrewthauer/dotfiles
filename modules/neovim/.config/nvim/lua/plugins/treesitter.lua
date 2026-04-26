return {
  -- syntax highlighting, etc.
  -- https://github.com/nvim-treesitter/nvim-treesitter
  -- https://github.com/tree-sitter/tree-sitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false, -- lazy loading not supported in new API
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    opts_extend = { "ensure_installed" },
    opts = {
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
    },
    config = function(_, opts)
      local ensure_installed = opts.ensure_installed or {}
      if type(ensure_installed) == "table" then
        ---@diagnostic disable-next-line: param-type-mismatch
        ensure_installed = require("util").table.dedupe(ensure_installed)
      end
      require("nvim-treesitter").install(ensure_installed)

      -- Neovim 0.12 only ships ftplugins that call vim.treesitter.start() for
      -- help/lua/markdown/query. Enable it for everything else here.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(ev) pcall(vim.treesitter.start, ev.buf) end,
      })
    end,
  },

  -- treesitter text objects
  -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = {
          lookahead = true,
          selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
            ["@class.outer"] = "<c-v>", -- blockwise
          },
          include_surrounding_whitespace = true,
        },
        move = {
          set_jumps = true,
        },
      })

      -- select keymaps
      local select = require("nvim-treesitter-textobjects.select")
      vim.keymap.set({ "x", "o" }, "af", function() select.select_textobject("@function.outer", "textobjects") end)
      vim.keymap.set({ "x", "o" }, "if", function() select.select_textobject("@function.inner", "textobjects") end)
      vim.keymap.set({ "x", "o" }, "ac", function() select.select_textobject("@class.outer", "textobjects") end)
      vim.keymap.set({ "x", "o" }, "ic", function() select.select_textobject("@class.inner", "textobjects") end, { desc = "Select inner part of a class region" })
      vim.keymap.set({ "x", "o" }, "as", function() select.select_textobject("@local.scope", "locals") end, { desc = "Select language scope" })

      -- move keymaps
      local move = require("nvim-treesitter-textobjects.move")
      vim.keymap.set({ "n", "x", "o" }, "]f", function() move.goto_next_start("@function.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "]c", function() move.goto_next_start("@class.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "]a", function() move.goto_next_start("@parameter.inner", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "]F", function() move.goto_next_end("@function.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "]C", function() move.goto_next_end("@class.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "]A", function() move.goto_next_end("@parameter.inner", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@function.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "[c", function() move.goto_previous_start("@class.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "[a", function() move.goto_previous_start("@parameter.inner", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "[F", function() move.goto_previous_end("@function.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "[C", function() move.goto_previous_end("@class.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "[A", function() move.goto_previous_end("@parameter.inner", "textobjects") end)
    end,
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
