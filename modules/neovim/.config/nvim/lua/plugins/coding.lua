return {
  -- comments
  -- https://github.com/echasnovski/mini.comment
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        -- Toggle comment (like `gcip` - comment inner paragraph) for both
        -- Normal and Visual modes
        comment = "gc",
        -- Toggle comment on current line
        comment_line = "gcc",
        -- Toggle comment on visual selection
        comment_visual = "gc",
        -- Define 'comment' textobject (like `dgc` - delete whole comment block)
        -- Works also in Visual mode if mapping differs from `comment_visual`
        textobject = "gc",
      },
    },
  },

  -- auto pairs
  -- https://github.com/echasnovski/mini.pairs
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    keys = {
      {
        "<leader>up",
        function()
          local Util = require("lazy.core.util")
          vim.g.minipairs_disable = not vim.g.minipairs_disable
          if vim.g.minipairs_disable then
            Util.warn("Disabled auto pairs", { title = "Option" })
          else
            Util.info("Enabled auto pairs", { title = "Option" })
          end
        end,
        desc = "Toggle auto pairs",
      },
    },
  },

  -- Fast and feature-rich surround actions. For text that includes
  -- surrounding characters like brackets or quotes, this allows you
  -- to select the text inside, change or modify the surrounding characters,
  -- and more.
  -- https://github.com/echasnovski/mini.surround
  {
    "echasnovski/mini.surround",
    keys = function(_, keys)
      local mappings = {}
      -- -- Populate the keys based on the user's options
      -- local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      -- local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      -- local mappings = {
      --   { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
      --   { opts.mappings.delete, desc = "Delete surrounding" },
      --   { opts.mappings.find, desc = "Find right surrounding" },
      --   { opts.mappings.find_left, desc = "Find left surrounding" },
      --   { opts.mappings.highlight, desc = "Highlight surrounding" },
      --   { opts.mappings.replace, desc = "Replace surrounding" },
      --   { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      -- }
      -- mappings = vim.tbl_filter(function(m)
      --   return m[1] and #m[1] > 0
      -- end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },
}
