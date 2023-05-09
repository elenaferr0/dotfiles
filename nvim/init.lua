require "paq" {
    "savq/paq-nvim", -- Let Paq manage itself

    "neovim/nvim-lspconfig",

    { "lervag/vimtex",                   opt = true }, -- Use braces when passing options

    { 'nvim-treesitter/nvim-treesitter', run = function() vim.cmd 'TSUpdate' end },
}

require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = true
})

require 'visimp' {
    languages = {
        'c',
        'java',
        'javascript',
        'json',
        'latex',
        'python',
        'lua',
    }
}

require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
})

vim.g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
        unstaged = "",
        staged = "S",
        unmerged = "",
        renamed = "➜",
        deleted = "",
        untracked = "U",
        ignored = "◌",
    },
    folder = {
        -- arrow_open = " ",
        -- arrow_closed = "",
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
    },
}
-- setup must be called before loading
vim.cmd.colorscheme "catppuccin"
vim.o.relativenumber = true
vim.o.number = true
vim.opt.colorcolumn = '0'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- vim.cmd("set expandtab");
vim.cmd("command! T NvimTreeToggle")

local arrow_keys = { '<Up>', '<Down>', '<Left>', '<Right>' }

for _, key in ipairs(arrow_keys) do
    vim.api.nvim_set_keymap('n', key, '<Nop>', { noremap = true })
    -- vim.api.nvim_set_keymap('c', key, '<Nop>', { noremap = true })
    -- vim.api.nvim_set_keymap('i', key, '<Nop>', { noremap = true })
    vim.api.nvim_set_keymap('v', key, '<Nop>', { noremap = true })
end
