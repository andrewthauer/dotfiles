return {
  -- zenburn for nvim
  -- https://github.com/phha/zenburn.nvim
  {
    "phha/zenburn.nvim",
    lazy = false,
    priority = 1000, -- make sure to load this before other plugins start
    cond = vim.g.colorscheme == "zenburn",
    config = function()
      vim.cmd("colorscheme zenburn")
    end,
  },

  -- zenbones
  -- https://github.com/mcchrish/zenbones.nvim
  {
    "mcchrish/zenbones.nvim",
    dependencies = {
      "rktjmp/lush.nvim",
    },
    lazy = false,
    priority = 1000, -- make sure to load this before other plugins start
    cond = vim.g.colorscheme == "zenbones",
    config = function()
      -- variants
      --   zenwritten
      --   neobones
      --   vimbones
      --   rosebones
      --   forestbone
      --   nordbones
      --   tokyobones
      --   seoulbones
      --   duckbones
      --   zenburned
      --   kanagawabones
      vim.g.zenbones_variant = "zenburned"
      local colorscheme = vim.g.zenbones_variant or "zenbones"
      vim.cmd("colorscheme " .. colorscheme)
    end,
  },
}
