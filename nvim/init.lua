require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = true
})

-- require('kanagawa').setup({
--     transparent = true,
--     colors = {
--         theme = {
--             dragon = {},
--             all = {
--                 ui = {
--                     bg_gutter = "none"
--                 }
--             }
--         }
--     }
-- })

require 'visimp' {
    autopairs = {},
    comment = {},
    latex = {
        texlive = true
    },
    lsp = {},
    lspsignature = {},
    lspformat = {},
    blankline = {},
    gitsigns = {},
    icons = {},
    languages = {
        'c',
        'java',
        'javascript',
        'json',
        'latex',
        'python',
        'lua',
        'bash',
        'dart'
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
    -- tabline = {
    --     lualine_a = {},
    --     lualine_b = {},
    --     lualine_c = { tabline.tabline_buffers },
    --     lualine_x = { tabline.tabline_tabs },
    --     lualine_y = {},
    --     lualine_z = {},
    -- }
}
require('lualine').setup(lualine_config)


-- local bufferline = require('bufferline')
-- bufferline.setup {
--     options = {
--         mode = "buffers",                               -- set to "tabs" to only show tabpages instead
--         style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
--         themable = true,                                -- allows highlight groups to be overriden i.e. sets highlights as default
--         numbers = "buffer_id",
--         indicator = {
--             style = 'underline',
--         },
--         buffer_close_icon = '󰅖',
--         modified_icon = '●',
--         close_icon = '',
--         left_trunc_marker = '',
--         right_trunc_marker = '',
--         --- name_formatter can be used to change the buffer's label in the bufferline.
--         --- Please note some names can/will break the
--         --- bufferline so use this at your discretion knowing that it has
--         --- some limitations that will *NOT* be fixed.
--         name_formatter = function(buf) -- buf contains:
--             -- name                | str        | the basename of the active file
--             -- path                | str        | the full path of the active file
--             -- bufnr (buffer only) | int        | the number of the active buffer
--             -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
--             -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
--         end,
--         max_name_length = 18,
--         max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
--         truncate_names = true,  -- whether or not tab names should be truncated
--         tab_size = 18,
--         diagnostics = "nvim_lsp",
--         diagnostics_update_in_insert = false,
--         offsets = {
--             {
--                 filetype = "NvimTree",
--                 text = "File Explorer",
--                 text_align = "center",
--                 separator = true
--             }
--         },
--         color_icons = true, -- whether or not to add the filetype icon highlights
--         get_element_icon = function(element)
--             -- element consists of {filetype: string, path: string, extension: string, directory: string}
--             -- This can be used to change how bufferline fetches the icon
--             -- for an element e.g. a buffer or a tab.
--             -- e.g.
--             local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
--             return icon, hl
--         end,
--         show_buffer_icons = true, -- disable filetype icons for buffers
--         show_buffer_close_icons = true,
--         show_close_icon = true,
--         show_tab_indicators = true,
--         show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
--         persist_buffer_sort = true,   -- whether or not custom sorted buffers should persist
--         separator_style = "thick",
--         enforce_regular_tabs = false,
--         always_show_bufferline = true,
--         hover = {
--             enabled = true,
--             delay = 200,
--             reveal = { 'close' }
--         },
--         sort_by =
--         'insert_after_current' -- |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
--     },
-- }
--
local telescope = require('telescope')

local telescope_config = {
    pickers = {
        find_files = { theme = 'dropdown' }
    },
    defaults = {
        grep_hidden = true,
        file_ignore_patterns = {
            "%.7z",
            "%.JPEG",
            "%.JPG",
            "%.MOV",
            "%.RAF",
            "%.burp",
            "%.bz2",
            "%.cache",
            "%.class",
            "%.dll",
            "%.docx",
            "%.dylib",
            "%.epub",
            "%.exe",
            "%.flac",
            "%.ico",
            "%.ipynb",
            "%.jar",
            "%.jpeg",
            "%.jpg",
            "%.lock",
            "%.mkv",
            "%.mov",
            "%.mp4",
            "%.otf",
            "%.pdb",
            "%.pdf",
            "%.png",
            "%.rar",
            "%.sqlite3",
            "%.svg",
            "%.tar",
            "%.tar.gz",
            "%.ttf",
            "%.webp",
            "%.zip",
            ".git/",
            ".gradle/",
            ".idea/",
            ".settings/",
            ".vale/",
            ".vscode/",
            "__pycache__/*",
            "build/",
            "env/",
            "gradle/",
            "node_modules/",
            "smalljre_*/*",
            "target/",
            "vendor/*",
        }
    }
}

telescope.setup(telescope_config)
telescope.load_extension('notify')

require('telekasten').setup({
    home = vim.fn.expand("~/docs/notes"), -- Put the name of your notes directory here
})

-- image preview

-- vim.cmd.colorscheme "kanagawa"
vim.cmd.colorscheme "catppuccin"
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.colorcolumn = '0'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.cmd("set splitbelow")
-- vim.cmd("autocmd BufWritePost *.md silent! !pandoc -f markdown -t pdf -o %:t:r.pdf %:t:r.md")

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
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
vim.api.nvim_set_keymap('n', '<leader>fn', ':Telescope notify<CR>', { noremap = true })

local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
vim.keymap.set('n', '<leader>fc', live_grep_args_shortcuts.grep_word_under_cursor)
vim.keymap.set('n', '<leader>fs', live_grep_args_shortcuts.grep_visual_selection)

-- buffer navigation
vim.api.nvim_set_keymap('n', '<leader>bd', ':bd<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bn', ':bn<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bp', ':bp<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>be', ':enew<CR>', { noremap = true })

vim.cmd('imap <silent><script><expr> <C-j> copilot#Accept("")')
vim.cmd("let g:copilot_no_tab_map = v:true")
vim.cmd("let g:copilot_assume_mapped = v:true")

local notify = require("notify")

local notify_config = {
    fps = 50,
    render = "compact",
}

notify.setup(notify_config)
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end

require("flutter-tools").setup {}

require("toggleterm").setup({
    size = function(term)
        if term.direction == "horizontal" then
            return 15
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
        end
    end,
    autochdir = true,
    autoscroll = true,
    open_mapping = [[<c-\>]],
})


-- vim.cmd(':nmap <F1> <nop>')

-- lsp config
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Buffer local mappings.
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<C-l>', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})


-- terminal keymaps
function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

require("lsp-file-operations").setup()

local tree_api = require("nvim-tree.api")
local tree_actions = {
    {
        name = "Create node",
        handler = tree_api.fs.create,
    },
    {
        name = "Remove node",
        handler = tree_api.fs.remove,
    },
    {
        name = "Trash node",
        handler = tree_api.fs.trash,
    },
    {
        name = "Rename node",
        handler = tree_api.fs.rename,
    },
    {
        name = "Fully rename node",
        handler = tree_api.fs.rename_sub,
    },
    {
        name = "Copy",
        handler = tree_api.fs.copy.node,
    },
}


vim.api.nvim_set_keymap("n", "<C-u>", ':lua require("nvim-tree.api").tree.toggle()<CR>',
    { silent = true, noremap = true })

local function tree_actions_menu(node)
    local entry_maker = function(menu_item)
        return {
            value = menu_item,
            ordinal = menu_item.name,
            display = menu_item.name,
        }
    end

    local finder = require("telescope.finders").new_table({
        results = tree_actions,
        entry_maker = entry_maker,
    })

    local sorter = require("telescope.sorters").get_generic_fuzzy_sorter()

    local default_options = {
        finder = finder,
        sorter = sorter,
        attach_mappings = function(prompt_buffer_number)
            local actions = require("telescope.actions")

            -- On item select
            actions.select_default:replace(function()
                local state = require("telescope.actions.state")
                local selection = state.get_selected_entry()
                -- Closing the picker
                actions.close(prompt_buffer_number)
                -- Executing the callback
                selection.value.handler(node)
            end)

            -- The following actions are disabled in this example
            -- You may want to map them too depending on your needs though
            actions.add_selection:replace(function()
            end)
            actions.remove_selection:replace(function()
            end)
            actions.toggle_selection:replace(function()
            end)
            actions.select_all:replace(function()
            end)
            actions.drop_all:replace(function()
            end)
            actions.toggle_all:replace(function()
            end)

            return true
        end,
    }

    -- Opening the menu
    require("telescope.pickers").new({ prompt_title = "Tree menu" }, default_options):find()
end

vim.keymap.set("n", "<C-P>", tree_actions_menu, { buffer = buffer, noremap = true, silent = true })

require 'nvim-treesitter.configs'.setup {
    autotag = {
        enable = true,
    }
}
