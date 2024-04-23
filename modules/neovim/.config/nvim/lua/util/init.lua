local M = {}

-- M.keys = require("util.keys")
M.lazy = require("util.lazy")
M.lsp = require("util.lsp")
M.plugin = require("util.mason")
M.telescope = require("util.telescope")
M.toggle = require("util.toggle")
M.table = {}

--- Create a set from a list
function M.table.set(list)
  local set = {}
  for _, l in ipairs(list) do
    set[l] = true
  end
  return set
end

-- Find element v of l satisfying f(v)
function M.table.find(f, l)
  for _, v in ipairs(l) do
    if f(v) then
      return v
    end
  end
  return nil
end

--- Check if a module is available to be required
---@param module_name string The module to search for.
---@return boolean available # Whether the plugin is available.
function M.try_require(module_name)
  local module = pcall(require, module_name)
  return module ~= nil
end

-- Update all plugins
function M.update_all_plugins()
  -- TODO: run :LazyUpdate, :MasonUpdate, :TSUpdate in sequence
  -- require("lazy").update({ wait = true, mode = " })
end

---@diagnostic disable-next-line: undefined-doc-name
---@param opts { keys: LazyKeySpec[], buffer?: buffer }
function M.map_keys(opts)
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

-- Closes all buffers except the current one
function M.close_other_buffers()
  local current_buf = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current_buf then
      vim.api.nvim_buf_delete(buf, { force = false })
    end
  end
end

-- Clear all named registers
function M.clear_registers()
  print("Clearing registers")
  vim.cmd([[
    let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
    for r in regs
    call setreg(r, [])
    endfor
  ]])
end

return M
