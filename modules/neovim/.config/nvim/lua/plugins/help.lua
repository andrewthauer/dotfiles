return {
  -- which-key helps you remember key bindings by showing a popup
  -- with the active keybindings of the command you started typing.
  -- https://github.com/folke/which-key.nvim
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      defaults = {
        mode = { "n", "v" },
        ["g"] = { name = "+Goto" },
        ["gs"] = { name = "+Surround" },
        ["z"] = { name = "+Fold" },
        ["]"] = { name = "+Next" },
        ["["] = { name = "+Prev" },
        ["<leader><tab>"] = { name = "+Tabs" },
        ["<leader>b"] = { name = "+Buffers" },
        ["<leader>c"] = { name = "+Code" },
        ["<leader>d"] = { name = "+Document/Debug" },
        ["<leader>f"] = { name = "+File/find" },
        ["<leader>g"] = { name = "+Git" },
        ["<leader>gh"] = { name = "+Git Hunks" },
        ["<leader>q"] = { name = "+Quit/Session" },
        ["<leader>r"] = { name = "+Rename" },
        ["<leader>s"] = { name = "+Search" },
        ["<leader>u"] = { name = "+UI Toggles" },
        ["<leader>w"] = { name = "+Windows" },
        ["<leader>x"] = { name = "+Diagnostics / Quickfix" },
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.register(opts.defaults)
    end,
  },

  -- cheatsheet.nvim
  -- https://github.com/sudormrfbin/cheatsheet.nvim
  {
    "sudormrfbin/cheatsheet.nvim",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
    },
  },
}
