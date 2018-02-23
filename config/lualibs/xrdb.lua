--
-- XRDB interface module

-- add local load path
userHome = os.getenv('HOME')
package.cpath = package.cpath .. ";" .. userHome .. "/.config/lualibs/?.so"

-- require xresources C module
require 'xresources'
require 'string'

-- module index
local module_xrdb = {}

-- query the xrdb database
local function xrdb_get_color_string(resource_name)
  return xrdb_get_resource_string(resource_name)
end

local function parse_string_resource(resource_name)
  -- search, match and replace the # character at the start of an xresouce value
  r_str = string.gsub(xrdb_get_color_string(resource_name), "^#", "0x", 1)
  return r_str
end

-- map lua functions
module_xrdb.parse_string_resource = parse_string_resource

-- return module
return module_xrdb

--
