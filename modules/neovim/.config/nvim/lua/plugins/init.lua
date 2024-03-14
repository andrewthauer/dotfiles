local lazyvim_full = vim.g.lazyvim == true

-- Default LazyVim spec
local lazyvim_spec = {
  "LazyVim/LazyVim",
  import = "lazyvim.plugins",
  opts = {
    colorscheme = vim.g.colorscheme,
  },
}

-- If we are not using full LazyVim, we might might want to use some utils
-- from it. This overrides the spec to load it without being initialized or
-- configured without plugins, etc.
if lazyvim_full == false then
  -- Override LazyVim spec only be available for requireing
  lazyvim_spec = {
    "LazyVim/LazyVim",
    import = nil,
    lazy = false,
    init = function() end,
    config = false,
  }

  -- Also set options, so leader key is configured first
  require("config.options")
end

return {
  -- NOTE: Only require this when not using LazyVim
  {
    name = "core-local",
    dir = ".", -- tell lazy this is not a remote plugin
    dev = true,
    priority = 10001, -- load before everything
    lazy = false,
    cond = lazyvim_full == false,
    init = function()
      -- load configuration manually
      require("config.keymaps")
      require("config.autocmds")
    end,
  },

  -- add dynamically builtin lazyvim spec
  lazyvim_spec,
}
