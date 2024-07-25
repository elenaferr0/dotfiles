return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use { 'catppuccin/nvim', as = 'catppuccin' }
    -- use 'dasupradyumna/midnight.nvim'
    use 'lukas-reineke/lsp-format.nvim'
    use 'nvim-tree/nvim-tree.lua'
    use 'ryanoasis/vim-devicons'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = { 
            { 'nvim-lua/plenary.nvim' },
            { "nvim-telescope/telescope-live-grep-args.nvim" },
        }
    }
    -- use {
    --     'nvim-telescope/telescope-file-browser.nvim',
    --     requires = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' }
    -- }
    -- use 'donRaphaco/neotex'
    use 'tpope/vim-surround'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use {
        'kdheepak/tabline.nvim',
        requires = { { 'hoob3rt/lualine.nvim', opt = true }, { 'kyazdani42/nvim-web-devicons', opt = true } }
    }
    use 'tomtom/tcomment_vim'
    use 'tpope/vim-repeat'
    use 'lucat1/visimp'
    use 'justinmk/vim-sneak'
    use 'neovim/nvim-lspconfig'
    use {
        'akinsho/flutter-tools.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim', -- optional for vim.ui.select
        },
    }
    use 'mfussenegger/nvim-dap' -- flutter debug capabilities
    -- use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
    use 'github/copilot.vim'
    use { "akinsho/toggleterm.nvim", tag = '*' }
    use {
      'antosha417/nvim-lsp-file-operations',
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-tree.lua",
      }
    }
    use 'nyoom-engineering/nyoom.nvim'
end)
