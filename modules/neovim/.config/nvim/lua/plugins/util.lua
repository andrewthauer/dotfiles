local function mason_ensure_installed(opts)
  -- Borrowed from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/init.lua
  local mr = require("mason-registry")

  mr:on("package:install:success", function()
    vim.defer_fn(function()
      -- trigger FileType event to possibly load this newly installed LSP server
      require("lazy.core.handler.event").trigger({
        event = "FileType",
        buf = vim.api.nvim_get_current_buf(),
      })
    end, 100)
  end)

  local function ensure_installed()
    for _, tool in ipairs(opts.ensure_installed or {}) do
      local p = mr.get_package(tool)
      if not p:is_installed() then
        p:install()
      end
    end
  end

  if mr.refresh then
    mr.refresh(ensure_installed)
  else
    ensure_installed()
  end
end

return {
  -- utils used by other libraries
  -- https://github.com/nvim-lua/plenary.nvim
  { "nvim-lua/plenary.nvim" },

  -- Portable package manager for Neovim
  -- https://github.com/mason-org/mason.nvim
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    config = function(_, opts)
      require("mason").setup(opts)
      mason_ensure_installed(opts)
    end,
  },
}
