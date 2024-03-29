local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Better escape using jk in insert and terminal mode
keymap("i", "jk", "<ESC>", default_opts)
keymap("t", "jk", "<C-\\><C-n>", default_opts)

-- Center search results
keymap("n", "n", "nzz", default_opts)
keymap("n", "N", "Nzz", default_opts)

-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_opts)

-- Move selected line / block of text in visual mode
keymap("x", "K", ":move '<-2<CR>gv-gv", default_opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", default_opts)

-- Do not yank when pressing x
keymap('n', 'x', '"_x', default_opts)

-- Increment/decrement
keymap('n', '+', '<C-a>', default_opts)
keymap('n', '-', '<C-x>', default_opts)

-- Delete a word backwards
--keymap('n', 'dw', 'vb"_d', default_opts)

-- Select all
keymap('n', '<C-a>', 'gg<S-v>G', default_opts)

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- New tab
keymap('n', 'te', ':tabedit', default_opts)

-- Split window
keymap('n', 'ss', ':split<Return><C-w>w', default_opts)
keymap('n', 'sv', ':vsplit<Return><C-w>w', default_opts)

-- Move window
keymap('n', '<Space>', '<C-w>w', default_opts)
keymap('', 'sh', '<C-w>h', default_opts)
keymap('', 'sk', '<C-w>k', default_opts)
keymap('', 'sj', '<C-w>j', default_opts)
keymap('', 'sl', '<C-w>l', default_opts)

-- Resize window
keymap('n', '<C-w><left>', '<C-w><', default_opts)
keymap('n', '<C-w><right>', '<C-w>>', default_opts)
keymap('n', '<C-w><up>', '<C-w>+', default_opts)
keymap('n', '<C-w><down>', '<C-w>-', default_opts)
