-- This module allows us to enable/disable plugins in a single place

return {
  -- always enabled
  { "akinsho/bufferline.nvim", enabled = false },
  { "echasnovski/mini.pairs", enabled = false },
  { "echasnovski/mini.surround", enabled = false },

  -- add maybe/later list
  -- { "echasnovski/mini.ai", enabled = false },
  -- { "echasnovski/mini.indentscope", enabled = false },
  -- { "folke/noice.nvim", enabled = false },
  -- { "JoosepAlviste/nvim-ts-context-commentstring", enabled = lazyvim_enabled },
  -- { "mfussenegger/nvim-lint", enabled = false },
  -- { "rcarriga/nvim-notify", enabled = false },
  -- { "RRethy/vim-illuminate", enabled = false },
  -- { "windwp/nvim-ts-autotag", enabled = false },
}
