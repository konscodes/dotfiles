-- Install plugin manager Packer
-- https://github.com/wbthomason/packer.nvim
local found, packer = pcall(require, "packer")
if not found then
	print("Packer is not installed")
	return
end

-- Only required if you have packer configured as `opt`
--vim.cmd [[packadd packer.nvim]]

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'
  -- Your plugins go here
end)
