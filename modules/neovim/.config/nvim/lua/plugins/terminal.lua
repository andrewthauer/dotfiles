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
}
