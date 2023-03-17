local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    --Themes
    use 'morhetz/gruvbox'
    use 'kyazdani42/nvim-web-devicons'
    use 'ryanoasis/vim-devicons'
    use 'folke/tokyonight.nvim'
    use 'kaicataldo/material.vim'

    --Editor
    use 'nvim-lualine/lualine.nvim'
    use 'kdheepak/tabline.nvim'

    --Dashboard
    use {
        "startup-nvim/startup.nvim",
        requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
        config = function()
            require("startup").setup { theme = "dashboard" }
        end,
    }

    --Code Completion
    use 'neovim/nvim-lspconfig'
    use 'ray-x/lsp_signature.nvim'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'glepnir/lspsaga.nvim'

    --Syntax Highliting
    use 'nvim-treesitter/nvim-treesitter'
    
    --Code Snippets
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
    use 'rafamadriz/friendly-snippets'
    
    --Debugger, muti-language support
    --use 'puremourning/vimspector'

    --Telescope
    use 'airblade/vim-rooter'
    use 'BurntSushi/ripgrep'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-github.nvim'

    --NerdTree
    use 'preservim/nerdtree'
    use 'Xuyuanp/nerdtree-git-plugin'
    use 'tiagofumo/vim-nerdtree-syntax-highlight'

    --FloatTerm
    use 'voldikss/vim-floaterm'

    --Autoindents
    use 'jiangmiao/auto-pairs'
    --use 'lukas-reineke/indent-blankline.nvim'

    --Easymotion better vim movements
    use 'easymotion/vim-easymotion'

    --Git 
    use 'tpope/vim-fugitive'
    use 'lewis6991/gitsigns.nvim'

    --Discord Rich Presence
    use 'andweeb/presence.nvim'
        
  if packer_bootstrap then
      require('packer').sync()
  end
end)
