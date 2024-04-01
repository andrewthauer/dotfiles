local M = {}

M.keys = require("util.keys")
M.lazy = require("util.lazy")
M.telescope = require("util.telescope")
M.toggle = require("util.toggle")
M.vim = require("util.vim")

--- Check if a module is available to be required
---@param module_name string The module to search for.
---@return boolean available # Whether the plugin is available.
function M.is_mod_available(module_name)
  local module = pcall(require, module_name)
  return module ~= nil
end

return M
