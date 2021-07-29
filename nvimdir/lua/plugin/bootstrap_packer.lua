-- bootstrap packer via lua hook
-- just git-clone the plugin repo if not present in this neovim installation

local fsutil = require('utils.filesystem')

-- define installation path
local pluginPath = '/site/pack/packer/start/packer.nvim'
local packer_install_path = vim.fn.stdpath('data')..pluginPath

-- check and clone packer
local function bootstrapPacker(install_path)
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.api.nvim_command 'packadd packer.nvim'
end

-- check plugin installation
if fsutil.assertGitBinaryExists('/usr/bin/git') then
  fsutil.preparePath(packer_install_path)
  if vim.fn.empty(vim.fn.glob(packer_install_path)) > 0 then
    bootstrapPacker(packer_install_path)
  end
end

