local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = ' '

--Save using modern keybinds
map('n', '<C-s>', ':w<CR>', opts)
map('i', '<C-s>', '<Esc>:w<CR>a', opts)

--Copy and paste
map('v', 'y', 'y', opts)
map('v', 'p', 'p]', opts)
map('n', 'p', 'p`]', opts)

map('v', '<C-c>', '"+y', opts)
map('n', '<C-c>', '"+yy', opts)
map('v', '<C-v>', '"+p', opts)
map('n', '<C-v>', '"+p', opts)
map('i', '<C-v>', '"+p', opts)
map('i', '<C-v>', '<Esc>"+pa', opts)

--Tabs
map('n', '<C-t>', ':tabnew<CR>', opts)
map('n', '<C-h>', 'gT', opts)
map('n', '<C-l>', 'gt', opts)
map('n', '<C-q>', ':tabclose<CR>', opts)
map('n', '<A-l>', ':TablineBufferNext<CR>', opts)
map('n', '<A-h>', ':TablineBufferPrevious<CR>', opts)
map('n', '<A-q>', ':bd!<CR>', opts)

--Telescope
map('n', '<leader>.', ':Telescope find_files<CR>', opts)
map('n', '<leader>r', ':Telescope live_grep<CR>', opts)

--NerdTree
map('n', '<leader>n', ':NERDTreeFocus<CR>', opts)
map('n', '<C-nt>', ':NERDTree<CR>', opts)
map('n', '<C-n>', ':NERDTreeToggle<CR>', opts)
map('n', '<C-f>', ':NERDTreeFind<CR>', opts)

--Command mode
map('n', ';', ':', opts)

--Easymotion
map('n', '<leader>f', '<Plug>(easymotion-overwin-f)', opts)
map('n', '<leader>j', '<Plug>(easymotion-overwin-line)', opts)
map('n', '<leader>k', '<Plug>(easymotion-overwin-line)', opts)
map('n', '<leader>w', '<Plug>(easymotion-overwin-w)', opts)
