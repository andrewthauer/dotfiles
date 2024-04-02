local M = {}

M.buffers = {}
M.registers = {}

-- Closes all buffers except the current one
function M.buffers.close_others()
  local current_buf = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current_buf then
      vim.api.nvim_buf_delete(buf, { force = false })
    end
  end
end

-- Clear all named registers
function M.registers.clear()
  print("Clearing registers")
  vim.cmd([[
    let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-"', '\zs')
    for r in regs
    call setreg(r, [])
    endfor
  ]])
end

return M
