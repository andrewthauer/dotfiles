---@diagnostic disable: duplicate-set-field

---@class Toggle
---@field name string
---@field get fun():boolean
---@field set fun(state:boolean)

local M = {}

---@param toggle Toggle
function M.wrap(toggle)
  return setmetatable(toggle, {
    __call = function()
      toggle.set(not toggle.get())
      local state = toggle.get()
      if state then
        print(string.format("Enabled %s", toggle.name))
      else
        print(string.format("Disabled %s", toggle.name))
      end
      return state
    end,
  })
end

---@param lhs string
---@param toggle Toggle
function M.map(lhs, toggle)
  local t = M.wrap(toggle)
  vim.keymap.set("n", lhs, function()
    t()
  end, { desc = "Toggle " .. toggle.name })
end

---@param opts? {values?: {[1]:any, [2]:any}, name?: string}
function M.option(option, opts)
  opts = opts or {}
  local name = opts.name or option
  local on = opts.values and opts.values[2] or true
  local off = opts.values and opts.values[1] or false
  return M.wrap({
    name = name,
    get = function()
      return vim.opt_local[option]:get() == on
    end,
    set = function(state)
      vim.opt_local[option] = state and on or off
    end,
  })
end

-- toggle line numbers
local nu = { number = true, relativenumber = true }
M.number = M.wrap({
  name = "Line Numbers",
  get = function()
    return vim.opt_local.number:get() or vim.opt_local.relativenumber:get()
  end,
  set = function(state)
    if state then
      vim.opt_local.number = nu.number
      vim.opt_local.relativenumber = nu.relativenumber
    else
      nu = { number = vim.opt_local.number:get(), relativenumber = vim.opt_local.relativenumber:get() }
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
    end
  end,
})

-- Toggle diagnostics on and off
M.diagnostics = M.wrap({
  name = "Diagnostics",
  get = function()
    local enabled = false
    if vim.diagnostic.is_enabled then
      enabled = vim.diagnostic.is_enabled()
    elseif vim.diagnostic.is_disabled then
      enabled = not vim.diagnostic.is_disabled()
    end
    return enabled
  end,
  set = function(state)
    if vim.fn.has("nvim-0.10") == 0 then
      if state then
        pcall(vim.diagnostic.enable)
      else
        pcall(vim.diagnostic.disable)
      end
    else
      vim.diagnostic.enable(state)
    end
  end,
})

-- Toggle inlay hints on and off
M.inlay_hints = M.wrap({
  name = "Inlay Hints",
  get = function()
    return vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
  end,
  set = function(state)
    vim.lsp.inlay_hint.enable(state, { bufnr = 0 })
  end,
})

setmetatable(M, {
  __call = function(m, ...)
    return m.option(...)
  end,
})

return M
