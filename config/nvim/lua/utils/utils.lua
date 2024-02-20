-- utility module
local M = {}

-- neovim api wrappers
local nvim_cmd = vim.api.nvim_command
local nvim_map = vim.api.nvim_set_keymap

-- element in array check
local function contains(array, element)
  for e=1,#array do
    if array[e] == element then
      return true
    end
  end
  return false
end

-- insert maps into vim
local function create_mapping(maplist)
  for _, mapping in ipairs(maplist) do
    nvim_map(unpack(mapping))
  end
end

-- run an autocommand
local function autocmd(cmdlist)
  if type(cmdlist) == "table" then
    nvim_cmd('autocmd ' .. table.concat(cmdlist, ' '))
  end
end

-- clear old autocommands
local function autocmd_clear() nvim_cmd('autocmd!') end

-- define an autogroup in vim
local function autogroup(group_name, cmdlist)
  nvim_cmd('augroup ' .. group_name)
  autocmd_clear()
  for _, cmdtable in ipairs(cmdlist) do
    autocmd(cmdtable)
  end
  nvim_cmd('augroup END')
end

-- Helper function for transparency formatting
local function alpha(t_value)
  return string.format("%x", math.floor(255 * (t_value or 0.8)))
end

M.contains = contains
M.autogroup = autogroup
M.create_mapping = create_mapping
M.alpha = alpha
M.nvim_cmd = nvim_cmd

return M
