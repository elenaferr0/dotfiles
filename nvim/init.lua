require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = true
})

require 'visimp' {
    autopairs = {},
    comment = {},
    latex = {
        texlive = true
    },
    gitsigns = {},
    icons = {},
    languages = {
        'c',
        'java',
        'javascript',
        'json',
        'latex',
        'python',
        'lua'
    }
}

require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
        icons = {
            glyphs = {
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
            },
        }
    },
    hijack_directories = {
        enable = true,
        auto_open = true,
    },
    filters = {
        dotfiles = false,
    },
})


local tabline = require('tabline')

local tabline_config = {
    enable = true,
    options = {
        section_separators = { '', '' },
        component_separators = { '', '' },
        show_tabs_always = true,
        show_devicons = true,
        show_bufnr = true
    }
}

tabline.setup(tabline_config)

local lualine_config = {
    options = {
        theme = 'palenight',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { { 'branch', icon = '' }, 'diff' },
        lualine_c = { 'filename' },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    tabline = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { tabline.tabline_buffers },
        lualine_x = { tabline.tabline_tabs },
        lualine_y = {},
        lualine_z = {},
    }
}
require('lualine').setup(lualine_config)

local telescope_config = {
    pickers = {
        find_files = { theme = 'dropdown' }
    }
}
require('telescope').setup(telescope_config)

vim.cmd.colorscheme "catppuccin"
vim.o.relativenumber = true
vim.o.number = true
vim.opt.colorcolumn = '0'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.cmd("command! T NvimTreeToggle")
vim.cmd("set splitbelow")
vim.cmd("autocmd BufWritePost *.md silent! !pandoc -f markdown -t pdf -o %:t:r.pdf %:t:r.md")

local arrow_keys = { '<Up>', '<Down>', '<Left>', '<Right>' }

for _, key in ipairs(arrow_keys) do
    vim.api.nvim_set_keymap('n', key, '<Nop>', { noremap = true })
    -- vim.api.nvim_set_keymap('c', key, '<Nop>', { noremap = true })
    -- vim.api.nvim_set_keymap('i', key, '<Nop>', { noremap = true })
    vim.api.nvim_set_keymap('v', key, '<Nop>', { noremap = true })
end

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fm', builtin.marks, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- buffer navigation
vim.api.nvim_set_keymap('n', '<leader>bd', ':bd<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bn', ':bn<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bp', ':bp<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>be', ':enew<CR>', { noremap = true })
