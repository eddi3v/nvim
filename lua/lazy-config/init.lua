local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    -- Themes
    { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
    'morhetz/gruvbox',
    'kyazdani42/nvim-web-devicons',
    'ryanoasis/vim-devicons',
    'folke/tokyonight.nvim',
    'kaicataldo/material.vim',
    'chriskempson/base16-vim',

    -- Editor
    { 'nvim-lualine/lualine.nvim', config = function() require('plugins.lualine') end },
    { 'kdheepak/tabline.nvim', config = function() require('plugins.tabline') end },

    -- Dashboard
    {
        "startup-nvim/startup.nvim",
        dependencies = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
        config = function()
            require("startup").setup { theme = "dashboard" }
        end,
    },

    -- Code Completion
    { 'neovim/nvim-lspconfig', config = function() require('plugins.lsp') end },
    'ray-x/lsp_signature.nvim',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'glepnir/lspsaga.nvim',

    -- Syntax Highlighting
    { 'nvim-treesitter/nvim-treesitter', branch = 'master', build = ':TSUpdate', config = function() require('plugins.treesitter') end },

    -- Code Snippets
    'hrsh7th/vim-vsnip',
    'hrsh7th/vim-vsnip-integ',
    'rafamadriz/friendly-snippets',

    -- Debugger, muti-language support
    -- 'puremourning/vimspector',

    -- Telescope
    'airblade/vim-rooter',
    'BurntSushi/ripgrep',
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope.nvim', config = function() require('plugins.telescope') end },
    'nvim-telescope/telescope-github.nvim',

    -- NerdTree
    'preservim/nerdtree',
    'Xuyuanp/nerdtree-git-plugin',
    'tiagofumo/vim-nerdtree-syntax-highlight',

    -- FloatTerm
    { 'voldikss/vim-floaterm', config = function() require('plugins.floaterm') end },

    -- Autoindents
    'jiangmiao/auto-pairs',
    -- 'lukas-reineke/indent-blankline.nvim',

    -- Easymotion better vim movements
    'easymotion/vim-easymotion',

    -- Git 
    'tpope/vim-fugitive',
    { 'lewis6991/gitsigns.nvim', config = function() require('plugins.gitsigns') end },

    -- Discord Rich Presence
    'andweeb/presence.nvim',
}

require("lazy").setup(plugins)
