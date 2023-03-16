-- Highlight related configuration

-- Highlight the text line of the cursor
vim.opt.cursorline = true

-- Enables 24-bit RGB color in the TUI
vim.opt.termguicolors = true

-- Enables pseudo-transparency for a floating window
vim.opt.winblend = 0

-- Display the completion matches using the popup menu
vim.opt.wildoptions = 'pum'
-- Enables pseudo-transparency for the popup-menu
vim.opt.pumblend = 5

-- This option does NOT change the background color, 
-- it tells Nvim what the "inherited" (terminal/GUI) background looks like
vim.opt.background = 'dark'

-- Highlight yanked text for 200ms using the "Visual" highlight group
vim.cmd [[
  augroup highlight_yank
  autocmd!
  au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=100})
  augroup END
]]
