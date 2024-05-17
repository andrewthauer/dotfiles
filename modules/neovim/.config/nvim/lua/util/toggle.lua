---@diagnostic disable: duplicate-set-field

---@class Util.toggle
local M = {}

---@param silent boolean?
---@param values? {[1]:any, [2]:any}
function M.option(option, silent, values)
  if values then
    if vim.opt_local[option]:get() == values[1] then
      vim.opt_local[option] = values[2]
    else
      vim.opt_local[option] = values[1]
    end
    return print(string.format("Set %s to %s", option, vim.opt_local[option]:get()))
  end

  vim.opt_local[option] = not vim.opt_local[option]:get()
  if not silent then
    if vim.opt_local[option]:get() then
      print("Enabled " .. option)
    else
      print("Disabled " .. option)
    end
  end
end

local nu = { number = true, relativenumber = true }
function M.number()
  ---@diagnostic disable-next-line: undefined-field
  if vim.opt_local.number.get() or vim.opt_local.relativenumber:get() then
    ---@diagnostic disable-next-line: undefined-field
    nu = { number = vim.opt_local.number:get(), relativenumber = vim.opt_local.relativenumber:get() }
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    print("Disabled line numbers")
  else
    vim.opt_local.number = nu.number
    vim.opt_local.relativenumber = nu.relativenumber
    print("Enabled line numbers")
  end
end

-- Toggle diagnostics on and off
function M.diagnostics()
  local diagnostics_enabled = not vim.diagnostic.is_enabled()
  vim.diagnostic.enable(diagnostics_enabled)
  print(string.format("Toggle diagnostics to %s", diagnostics_enabled))
end

---@param buf? number
---@param value? boolean
---@diagnostic disable-next-line: unused-local
function M.inlay_hints(buf, value)
  -- TODO: Implement inlay hint toggling

  -- local ih = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
  --
  -- if type(ih) == "function" then
  --   ih(buf, value)
  -- elseif type(ih) == "table" and ih.enable then
  --   if value == nil then
  --     value = not ih.is_enabled(buf)
  --   end
  --
  --   ih.enable(buf, value)
  -- end
end

setmetatable(M, {
  __call = function(m, ...)
    return m.option(...)
  end,
})

return M
