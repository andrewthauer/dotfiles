local M = {}

-- Convert a string to a boolean
-- @param value (string) the value to convert
-- @param default (boolean) the default value to return if the conversion fails
-- @return (boolean) the converted value
function M.str_to_boolean(value, default)
  if value == "true" or value =="1" then
    return true
  elseif value == "false" or value == "0" then
    return false
  else
    return default or false
  end
end

return M
