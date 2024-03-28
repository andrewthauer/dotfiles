local M = {}

M.terminal = require("util.terminal")
M.toggle = require("util.toggle")

---@param keymaps table
function M.set_keymaps(keymaps)
  for _, keymap in pairs(keymaps) do
    vim.keymap.set(table.unpack(keymap))
  end
end

---@param name string
---@param fn fun(name:string)
function M.on_load(name, fn)
  local Config = require("lazy.core.config")
  if Config.plugins[name] and Config.plugins[name]._.loaded then
    fn(name)
  else
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

return M
