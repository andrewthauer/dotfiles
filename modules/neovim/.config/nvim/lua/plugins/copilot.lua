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
        dependencies = {
          {
            -- https://github.com/zbirenbaum/copilot-cmp
            "zbirenbaum/copilot-cmp",
            -- disable copilot in completion list (can be annoying)
            cond = false,
            config = function()
              require("copilot_cmp").setup()
            end,
          },
        },
        opts = function(_, opts)
          table.insert(opts.sources, 1, { name = "copilot" })
        end,
      },
    },
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        -- This is not recommened when using with with copilot-cmp
        enabled = true,
        auto_trigger = true,
        -- default keymaps
        -- keymap = {
        --   accept = "<M-l>",
        --   accept_word = false,
        --   accept_line = false,
        --   next = "<M-]>",
        --   prev = "<M-[>",
        --   dismiss = "<C-]>",
        -- },
      },
      filetypes = {
        help = false,
        hgcommit = false,
        gitcommit = false,
        gitrebase = false,
        -- enable all other filetypes
        ["*"] = true,
      },
    },
  },
}
