set nocompatible
filetype off

call plug#begin('~/.config/nvim/plugged')

"Themes
Plug 'morhetz/gruvbox'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

"Better tabs
Plug 'kdheepak/tabline.nvim'

"Code Completion
Plug 'neovim/nvim-lspconfig'
" Deprecated Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rafamadriz/friendly-snippets'
Plug 'glepnir/lspsaga.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

"Debugger, multi-language support
Plug 'puremourning/vimspector'

"FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'BurntSushi/ripgrep'

"NerdTree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

"FloatTerm
Plug 'voldikss/vim-floaterm'

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

"au ColorScheme * hi Normal ctermbg=none guibg=none
"au ColorScheme myspecialcolors hi Normal ctermbg=red guibg=red

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

lua << EOF
 require'tabline'.setup {
      -- Defaults configuration options
      enable = true,
      options = {
      -- If lualine is installed tabline will use separators configured in lualine by default.
      -- These options can be used to override those settings.
        section_separators = {'', ''},
        component_separators = {'', ''},
        max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
        show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
        show_devicons = true, -- this shows devicons in buffer section
        show_bufnr = false, -- this appends [bufnr] to buffer section,
        show_filename_only = false, -- shows bse filename only instead of relative path in filename
        modified_icon = "+ ", -- change the default modified icon
        modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
        show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
      }
    }
EOF

"Tree-sitter config
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "all",

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
" Worry about these later
"nnoremap <silent> <C-p> <cmd>lua vim.lsp.buf.signature_help()<CR>
"nnoremap <silent> <C-j> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
"nnoremap <silent> <C-k> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
"
"auto-format
"autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
"autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
"autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)

set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<C-j>"] = cmp.mapping(function(fallback)
        if vim.fn.pumvisible() == 1 then
            feedkey("<C-n>", "n")
        elseif cmp.visible() then
            cmp.select_next_item()
        else
            fallback()
        end
      end, {
        "i",
      }),
      ["<C-k>"] = cmp.mapping(function(fallback)
        if vim.fn.pumvisible() == 1 then
            feedkey("<C-p>", "n")
        elseif cmp.visible() then
            cmp.select_prev_item()
        else
            fallback()
        end
    end, {
      "i",
    }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
    capabilities = capabilities
  }
EOF

"FloatTerm Setup
let g:floaterm_shell = 'fish'
let g:floaterm_wintype = 'split'
let g:floaterm_height = 0.3
let g:floaterm_title = 'Terminal: $1/$2'
nnoremap <A-t> :FloatermNew<CR>
let g:floaterm_keymap_toggle = '<Space>t'

"Font settings
set guifont=TerminessTTF\ Nerd\ Font\ Mono:h16
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
set hidden

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

"Default Tabs
nnoremap <C-t> :tabnew <Enter>
nnoremap <C-h> gT
nnoremap <C-l> gt
nnoremap <C-q> :tabclose <Enter>
"Added tabs
nmap <A-l> :TablineBufferNext <Enter>
nmap <A-h> :TablineBufferPrevious <Enter>
nmap <A-q> :bd! <Enter>
"autoformat
nnoremap <silent> ff <cmd>lua vim.lsp.buf.formatting()<CR>

"FZF
nnoremap <Space>. :FZF <Enter>

"Nerdtree
nnoremap <Space>n :NERDTreeFocus<CR>
"nnoremap <C-t> :NERDTree<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <-f> :NERDTreeFind<CR>

"Command Mode remap
nnoremap ; :

"Easymotion
map <Space>  <Plug>(easymotion-prefix)
map <Space>f <Plug>(easymotion-overwin-f)
map <Space>j <Plug>(easymotion-overwin-line)
map <Space>k <Plug>(easymotion-overwin-line)
map <Space>w <Plug>(easymotion-overwin-w)C
