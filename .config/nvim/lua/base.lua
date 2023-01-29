-- https://neovim.io/doc/user/lua-guide.html#lua-guide-options

-- Clear any previously defined autocommands
vim.cmd('autocmd!')

-- Print the line number in front of each line (wo - window-scoped options)
vim.wo.number = true

-- Set the title to filename and path (adjustable format)
vim.opt.title = true

-- Copy indent from current line when starting a new line (on by default)
vim.opt.autoindent = true
vim.opt.smartindent = true

-- When there is a previous search pattern, highlight all its matches
vim.opt.hlsearch = true

-- Use the appropriate number of spaces to insert a <Tab>
vim.opt.expandtab = true
-- Inserts blanks according to 'shiftwidth' when <Tab> is used in front of the line
vim.opt.smarttab = true
vim.opt.shiftwidth = 4
-- Number of spaces that a <Tab> in the file counts for
vim.opt.tabstop = 4

-- Wrap lines
vim.opt.wrap = false
-- Every wrapped line will continue visually indented
vim.opt.breakindent = true

-- Scroll lines below and above the cursor
vim.opt.scrolloff = 10

-- Interactive splitscreen preview for :substitute command (E.g. :%s/pattern/shape/g)
vim.opt.inccommand = 'split'

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true

-- Finding files - Search down into subfolders
vim.opt.path:append { '**' }
vim.opt.wildignore:append { '*/node_modules/*' }

-- Undercurl
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])
