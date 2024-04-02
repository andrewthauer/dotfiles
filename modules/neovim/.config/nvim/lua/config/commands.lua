-- User commands go here

-- close all buffers except the current one
vim.api.nvim_create_user_command("BufCloseOthers", function()
  require("util").buffers.close_others()
end, {})

-- wipe all named registers
vim.api.nvim_create_user_command("RegClear", function()
  require("util").registers.clear()
end, {})
