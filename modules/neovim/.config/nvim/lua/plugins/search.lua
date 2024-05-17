return {
  -- search/replace in multiple files
  -- https://github.com/nvim-pack/nvim-spectre
  {
    "nvim-pack/nvim-spectre",
    build = false,
    cmd = "Spectre",
    opts = {
      open_cmd = "noswapfile vnew",
      default = {
        find = {
          cmd = "rg",
          options = { "ignore-case", "hidden" },
        },
      },
    },
    keys = {
      -- style: ignore start
      { "<leader>sr", '<cmd>lua require("spectre").open()<cr>', desc = "Replace in files (Spectre)" },
      { "<leader>S", '<cmd>lua require("spectre").toggle()<cr>', desc = "Toggle Spectre" },
      { "<leader>sw", '<cmd>lua  require("spectre").open_visual({ select_word = true })<cr>', desc = "Search current word" },
      { "<leader>sw", '<esc><cmd>lua  require("spectre").open_visual()<cr>', desc = "Search current word", mode = { "v" } },
      { "<leader>sp", '<cmd>lua  require("spectre").open_file_search({ select_word = true })<cr>', desc = "Search on current file" },
      -- style: ignore end
    },
  },
}
