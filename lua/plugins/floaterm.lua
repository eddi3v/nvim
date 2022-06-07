vim.cmd [[
let g:floaterm_shell = 'powershell'
let g:floaterm_wintype = 'split'
let g:floaterm_height = 0.4
let g:floaterm_title = 'Terminal: $1/$2'
nnoremap <A-t> :FloatermNew<CR>
let g:floaterm_keymap_toggle = '<leader>t'
]]
