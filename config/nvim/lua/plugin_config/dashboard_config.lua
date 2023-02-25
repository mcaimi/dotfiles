-- configure dashboard options

local home = os.getenv('HOME')
local db = require('dashboard')

local M = {}

local settings = {
  theme = 'hyper',
  preview = {
    command = 'bat -pp',
    file_path = home .. '/.config/nvim/logo.cat',
    file_height = 20,
    file_width = 100,
  },
}

local function init_dash()
  db.setup( settings )
end

M.init_dash = init_dash

return M
