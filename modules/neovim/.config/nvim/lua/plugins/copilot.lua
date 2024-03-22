return {
  -- copilot
  -- https://github.com/zbirenbaum/copilot.lua
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    cmd = "Copilot",
    build = ":Copilot auth",
    dependencies = {
      {
        "nvim-cmp",
        opts = function(_, opts)
          table.insert(opts.sources, 1, {
            name = "copilot",
            group_index = 1,
            priority = 100,
          })
        end,
      },
    },
    opts = {
      panel = {
        enabled = true,
        auto_refresh = true,
      },
      suggestion = {
        enabled = true,
        -- use the built-in keymapping for "accept" (<M-l>)
        auto_trigger = true,
        accept = false, -- disable built-in keymapping
      },
      -- panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
        ["*"] = true,
      },
    },
  },
}
