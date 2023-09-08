-- require("catppuccin").setup({
--     flavour = "mocha",
--     transparent_background = true
-- })

require 'visimp' {
    autopairs = {},
    comment = {},
    latex = {
        texlive = true
    },
    gitsigns = {},
    icons = {},
    -- languages = {
    --     'c',
    --     'java',
    --     'javascript',
    --     'json',
    --     'latex',
    --     'python',
    --     'lua'
    -- }
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


vim.cmd.colorscheme 'midnight'
vim.o.relativenumber = true
vim.o.number = true
vim.opt.colorcolumn = '80'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.cmd("set splitbelow")

-- disable arrow keys
local arrow_keys = { '<Up>', '<Down>', '<Left>', '<Right>' }
for _, key in ipairs(arrow_keys) do
    vim.api.nvim_set_keymap('n', key, '<Nop>', { noremap = true })
    -- vim.api.nvim_set_keymap('c', key, '<Nop>', { noremap = true })
    -- vim.api.nvim_set_keymap('i', key, '<Nop>', { noremap = true })
    vim.api.nvim_set_keymap('v', key, '<Nop>', { noremap = true })
end

-- telescope
local telescope = require('telescope')

local telescope_config = {
    pickers = {
        find_files = { theme = 'dropdown' }
    },
    extensions = {
        live_grep_args = {
            theme = "dropdown"
        }
    }
}

telescope.setup(telescope_config)
telescope.load_extension('flutter')
telescope.load_extension('live_grep_args')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fm', builtin.marks, {})
-- vim.keymap.set('n', '<leader>fg', telescope.extensions.live_grep_args.live_grep_args, {})
vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
-- grep word under cursor
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
vim.keymap.set('n', '<leader>fc', live_grep_args_shortcuts.grep_word_under_cursor)
vim.keymap.set('n', '<leader>fs', live_grep_args_shortcuts.grep_visual_selection)

-- buffer navigation
vim.api.nvim_set_keymap('n', '<leader>bd', ':bd<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bn', ':bn<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bp', ':bp<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>be', ':enew<CR>', { noremap = true })

-- lsp config
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}

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
        vim.keymap.set('n', '<C-F>', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

-- flutter tools setup
require("flutter-tools").setup {
    ui = {
        border = 'rounded',
        notification_style = 'native'
    },
    decorations = {
        statusline = {
          -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
          -- this will show the current version of the flutter app from the pubspec.yaml file
          app_version = true,
          -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
          -- this will show the currently running device if an application was started with a specific
          -- device
          device = true,
          -- set to true to be able use the 'flutter_tools_decorations.project_config' in your statusline
          -- this will show the currently selected project configuration
          project_config = false,
        }
    },
    debugger = { -- integrate with nvim dap + install dart code debugger
        enabled = true,
        run_via_dap = true, -- use dap instead of a plenary job to run flutter apps
        -- if empty dap will not stop on any exceptions, otherwise it will stop on those specified
        -- see |:help dap.set_exception_breakpoints()| for more info
        exception_breakpoints = {}
    },
    widget_guides = {
        enabled = true
    },
    closing_tags = {
        highlight = "ErrorMsg", -- highlight for the closing tag
        prefix = ">", -- character to use for close tag e.g. > Widget
        enabled = true -- set to false to disable
    },
    dev_log = {
      enabled = true,
      notify_errors = true, -- if there is an error whilst running then notify the user
      open_cmd = "tabedit", -- command to use to open the log buffer
    },
    dev_tools = {
      autostart = false, -- autostart devtools server if not detected
      auto_open_browser = false, -- Automatically opens devtools in the browser
    },
    outline = {
      open_cmd = "30vnew", -- command to use to open the outline buffer
      auto_open = false -- if true this will open the outline automatically when it is first populated
    },
    lsp = {
      color = { -- show the derived colours for dart variables
        enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
        background = false, -- highlight the background
        background_color = nil, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
        foreground = false, -- highlight the foreground
        virtual_text = true, -- show the highlight using virtual text
        virtual_text_str = "■", -- the virtual text character to highlight
      },
      -- on_attach = my_custom_on_attach,
      -- capabilities = my_custom_capabilities -- e.g. lsp_status capabilities
      --- OR you can specify a function to deactivate or change or control how the config is created
      -- capabilities = function(config)
      --   config.specificThingIDontWant = false
      --   return config
      -- end,
      -- see the link below for details on each option:
      -- https://github.com/dart-lang/sdk/blob/master/pkg/analysis_server/tool/lsp_spec/README.md#client-workspace-configuration
      settings = {
        showTodos = true,
        completeFunctionCalls = true,
        renameFilesWithClasses = "always",
        enableSnippets = true,
        updateImportsOnRename = true, -- Whether to update imports and other directives when files are renamed. Required for `FlutterRename` command.
      }
    }
}

vim.cmd('imap <silent><script><expr> <C-j> copilot#Accept("")')
vim.cmd("let g:copilot_no_tab_map = v:true")
vim.cmd("let g:copilot_assume_mapped = v:true")


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
    open_mapping = [[<C-\>]],
})

-- function that allows to easily switch between open terminal and editor
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- nvim tree config

require("lsp-file-operations").setup()
vim.api.nvim_set_keymap("n", "<C-h>", ":NvimTreeToggle<cr>", {silent = true, noremap = true})

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
			actions.add_selection:replace(function() end)
			actions.remove_selection:replace(function() end)
			actions.toggle_selection:replace(function() end)
			actions.select_all:replace(function() end)
			actions.drop_all:replace(function() end)
			actions.toggle_all:replace(function() end)

			return true
		end,
	}

	-- Opening the menu
	require("telescope.pickers").new({ prompt_title = "Tree menu" }, default_options):find()
end

vim.keymap.set("n", "<C-P>", tree_actions_menu, { buffer = buffer, noremap = true, silent = true })

