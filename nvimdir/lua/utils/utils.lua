-- utility module
local M = {}

-- element in array check
local function contains(array, element)
  for e=1,#array do
    if array[e] == element then
      return true
    end
  end
  return false
end

M.contains = contains

return M
