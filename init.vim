set nocompatible
filetype off

call plug#begin('~/.config/nvim/plugged')

"Themes
Plug 'morhetz/gruvbox'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

"Code Completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'BurntSushi/ripgrep'

"Autoindents
Plug 'jiangmiao/auto-pairs'

"Easymotion better vim movements
Plug 'easymotion/vim-easymotion'

"Git 
Plug 'tpope/vim-fugitive'

call plug#end()

"set background=dark
"let g:gruvbox_contrast_dark='medium'
let g:tokyonight_style = "storm"

" Change the "hint" color to the "orange" color, and make the "error" color bright red
let g:tokyonight_colors = {
  \ 'hint': 'orange',
  \ 'error': '#ff0000'
\ }

au ColorScheme * hi Normal ctermbg=none guibg=none
au ColorScheme myspecialcolors hi Normal ctermbg=red guibg=red

"Colorscheme and themes
colorscheme tokyonight

lua << EOF
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'tokyonight',
        section_separators = '', 
        component_separators = ''
    }
}
EOF

"Tree-sitter config
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  --ignore_install = { "c" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    --disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

"LSP configuration
" LSP config (the mappings used in the default file don't quite work right)
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

"auto-format
"autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
"autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
"autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)

"LSP Compe Autocomplete
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
let g:compe.source.emoji = v:true

"Editor settings
set number relativenumber
set nowrap 
set noshowmode
set smartcase
set hlsearch
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set smarttab
set virtualedit+=onemore

"Key binds
"Save
:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>a

"Copy and paste
vnoremap <silent> y y
vnoremap <silent> p p]
nnoremap <silent> p p`]

vmap <silent> <C-c> "+y
nmap <silent> <C-c> "+yy
vmap <silent> <C-v> "+p
nmap <silent> <C-v> "+p
imap <silent> <C-v> "+p
imap <silent> <C-v> <Esc>"+pa

"Tabs
nnoremap <C-t> :tabnew <Enter>
nnoremap <C-h> gT
nnoremap <C-l> gt
nnoremap <C-q> :tabclose <Enter>

"nvim-compe
inoremap <silent> <C-k> <C-p>
inoremap <silent> <C-j> <C-n>

"FZF
nnoremap <Space>. :FZF <Enter>

"Command Mode remap
nnoremap ; :

"Easymotion
map <Space> <Plug>(easymotion-prefix)
map <Space>f <Plug>(easymotion-overwin-f)
map <Space>j <Plug>(easymotion-overwin-line)
map <Space>k <Plug>(easymotion-overwin-line)
map <Space>w <Plug>(easymotion-overwin-w)
