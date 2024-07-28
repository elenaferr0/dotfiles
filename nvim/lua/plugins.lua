return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use { 'catppuccin/nvim', as = 'catppuccin' }
    -- use "rebelot/kanagawa.nvim"
    use 'folke/lsp-colors.nvim'
    use 'lukas-reineke/lsp-format.nvim'
    use 'ryanoasis/vim-devicons'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { "nvim-telescope/telescope-live-grep-args.nvim" },
        }
    }
    use 'tpope/vim-surround'
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    use {
        'kdheepak/tabline.nvim',
        requires = {
            { 'hoob3rt/lualine.nvim',         opt = true },
            { 'kyazdani42/nvim-web-devicons', opt = true }
        }
    }
    use 'tomtom/tcomment_vim'
    use { 'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons' }
    use 'tpope/vim-repeat'
    use 'rcarriga/nvim-notify'
    use {
        'akinsho/flutter-tools.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim', -- optional for vim.ui.select
        },
    }
    use { "akinsho/toggleterm.nvim", tag = '*' }
    use {
        'renerocksai/telekasten.nvim',
        requires = { 'nvim-telescope/telescope.nvim' }
    }
    use { 'justinmk/vim-sneak' }
    use {
        'antosha417/nvim-lsp-file-operations',
        requires = {
            "nvim-lua/plenary.nvim",
            -- "nvim-tree/nvim-tree.lua",
        }
    }
    use { 'windwp/nvim-ts-autotag' }
    use { 'kaarmu/typst.vim', ft = { 'typst' } }
end)
