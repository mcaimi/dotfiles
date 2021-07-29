-- configure bufferline plugin
local bf = require('bufferline')

-- termguicolor is required
if not vim.opt.termguicolors:get() then
  vim.opt.termguicolors = true

  -- load bufferline
  bf.setup()
end

