local M = {}

function M.config_files()
  require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
end

function M.dotfiles()
  require("telescope.builtin").find_files({ cwd = vim.env.DOTFILES_DIR })
end

return M
