-- filesystem utility functions

local cffi = require('ffi')
local M = {}

-- import native functions prototypes
cffi.cdef[[
  int mkdir(const char *pathname, int mode);
  int access(const char *path, int amode);
  char *strerror(int errnum);
]]

-- check whether git is installed
local function assertGitBinaryExists(binary_path)
  local fd = assert(io.open(binary_path, 'r'))
  if not (fd == nil) then
    fd:close()
    return true
  else
    return false
  end
end

-- utility functions
local function string_split(string_to_split)
  local path_string = string_to_split:gsub("^/", ""):gsub("/$", "")
  local components = {}
  for x in path_string:gmatch("[%w%-._]+") do
    table.insert(components, x)
  end
  return components
end

-- prepare target directory
local function assertDirExists(packer_target_dir)
  return 0 == cffi.C.access(packer_target_dir, 0)
end

local function makeDir(dir_path)
    local result = cffi.C.mkdir(dir_path, tonumber("700", 8))
    if result ~= 0 then
        return nil, cffi.string(cffi.C.strerror(cffi.errno()))
    end
    return 0, nil
end

local function preparePath(packer_target_dir)
  if not assertDirExists(packer_target_dir) then
    local pathChunks = string_split(packer_target_dir, '/')
    local fragment = '/' .. pathChunks[1]
    for i=2, #pathChunks do
      if not assertDirExists(fragment) then
        result, err = makeDir(fragment)
        if result == nil then
          return nil, err
        end
      end
      fragment = fragment .. '/' .. pathChunks[i]
    end
  end
end

-- export methods
M.assertGitBinaryExists = assertGitBinaryExists
M.string_split = string_split
M.assertDirExists = assertDirExists
M.makeDir = makeDir
M.preparePath = preparePath

-- return module
return M
