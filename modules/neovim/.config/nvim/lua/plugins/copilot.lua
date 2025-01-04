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
        "saghen/blink.cmp",
        dependencies = {
          {
            "giuxtaposition/blink-cmp-copilot",
          },
        },
        opts = {
          sources = {
            -- default = { "lsp", "path", "snippets", "buffer", "copilot" },
            providers = {
              copilot = {
                name = "copilot",
                module = "blink-cmp-copilot",
                score_offset = 100,
                async = true,
                transform_items = function(_, items)
                  local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                  local kind_idx = #CompletionItemKind + 1
                  CompletionItemKind[kind_idx] = "Copilot"
                  for _, item in ipairs(items) do
                    item.kind = kind_idx
                  end
                  return items
                end,
              },
            },
          },
        },
      },
    },
    opts = {
      panel = {
        enabled = false,
      },
      suggestion = {
        -- This is not recommened when using with with copilot-cmp or blink-cmp-copilot
        enabled = true,
        auto_trigger = true,
        -- default keymaps
        keymap = {
          -- accept = "<M-l>",
          -- accept_word = false,
          -- accept_line = false,
          -- next = "<M-]>",
          -- prev = "<M-[>",
          -- dismiss = "<C-]>",
        },
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

  -- copilot chat
  -- https://github.com/CopilotC-Nvim/CopilotChat.nvim
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    -- lazy = false,
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      debug = false, -- Enable debugging
      -- See Configuration section for rest
    },
    keys = {
      { "<leader>co", "<cmd>CopilotChat<cr>", desc = "Copilot Chat" },
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
