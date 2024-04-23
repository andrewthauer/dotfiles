local M = {}

function M.config_files()
  require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
end

return M
