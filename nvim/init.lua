require "paq" {
    "savq/paq-nvim", -- Let Paq manage itself

    "neovim/nvim-lspconfig",

    { "lervag/vimtex", opt = true }, -- Use braces when passing options

    { 'nvim-treesitter/nvim-treesitter', run = function() vim.cmd 'TSUpdate' end },
}

require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = true,
})

-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
vim.cmd("set number");
vim.cmd("set relativenumber");
vim.cmd("set tabstop=4");
vim.cmd("set shiftwidth=4");
vim.cmd("set expandtab");
