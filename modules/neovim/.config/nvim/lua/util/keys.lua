local M = {}

---@diagnostic disable-next-line: undefined-doc-name
---@param opts { keys: LazyKeySpec[], buffer?: buffer }
function M.set(opts)
  local keys = opts.keys
  local Keys = require("lazy.core.handler.keys")
  local keymaps = Keys.resolve(keys)

  for _, key in pairs(keymaps) do
    local key_opts = Keys.opts(key)

    ---@diagnostic disable-next-line: inject-field
    key_opts.has = nil
    ---@diagnostic disable-next-line: inject-field
    key_opts.silent = key_opts.silent ~= false
    ---@diagnostic disable-next-line: inject-field
    key_opts.buffer = opts.buffer or nil

    vim.keymap.set(key.mode or "n", key.lhs, key.rhs, key_opts)
  end
end

return M
