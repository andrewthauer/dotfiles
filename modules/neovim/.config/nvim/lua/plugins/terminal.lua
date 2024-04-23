return {
  -- manage multiple terminal windows
  -- https://github.com/akinsho/toggleterm.nvim
  {
    "akinsho/toggleterm.nvim",
    opts = {
      open_mapping = [[<c-/>]],
      size = function(term)
        if term.direction == "horizontal" then
          return 20
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
    },
  },

  -- open files & commands from term in current nvim instance
  -- https://github.com/willothy/flatten.nvim
  {
    "willothy/flatten.nvim",
    -- cond = false,
    lazy = false,
    -- Ensure that it runs first to minimize delay when opening file from terminal
    priority = 1001,
    opts = {
      block_for = {
        gitcommit = true,
        gitrebase = true,
      },
    },
    config = true,
  },
}
