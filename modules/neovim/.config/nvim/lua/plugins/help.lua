return {
  -- which-key helps you remember key bindings by showing a popup
  -- with the active keybindings of the command you started typing.
  -- https://github.com/folke/which-key.nvim
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    ---@diagnostic disable-next-line: unused-local
    config = function(_, _opts)
      local wk = require("which-key")
      wk.add({
        --   -- mode = { "n", "v" },
        { "g", desc = "+Goto" },
        { "gs", desc = "+Surround" },
        { "z", desc = "+Fold" },
        { "]", desc = "+Next" },
        { "[", desc = "+Prev" },
        { "<leader><tab>", desc = "+Tabs" },
        { "<leader>b", desc = "+Buffers" },
        { "<leader>c", desc = "+Code" },
        { "<leader>cc", desc = "+Calls (In/Out)" },
        { "<leader>ct", desc = "+Type Definitions" },
        { "<leader>d", desc = "+Document/Debug" },
        { "<leader>f", desc = "+File/find" },
        { "<leader>g", desc = "+Git/Goto" },
        { "<leader>gh", desc = "+Git Hunks" },
        { "<leader>m", desc = "+Multiple Cursors" },
        -- { "<leader>p", desc = "+Projects" },
        { "<leader>q", desc = "+Quit/Session" },
        { "<leader>r", desc = "+Rename" },
        { "<leader>s", desc = "+Search" },
        { "<leader>u", desc = "+UI Toggles" },
        { "<leader>w", desc = "+Windows/Workspace" },
        { "<leader>x", desc = "+Diagnostics/Quickfix" },
      })
    end,
  },
}
