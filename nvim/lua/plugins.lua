return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use { "catppuccin/nvim", as = "catppuccin" }
    use "lukas-reineke/lsp-format.nvim"
    use "windwp/nvim-autopairs"
    use "nvim-tree/nvim-tree.lua"
end)
