-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Telescope keymaps
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

-- Buffer navigation
vim.api.nvim_set_keymap('n', '<leader>bd', ':bd<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bn', ':bn<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bp', ':bp<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>be', ':enew<CR>', { noremap = true })

-- Nvim-tree keymaps
vim.api.nvim_set_keymap("n", "<C-u>", ':lua require("nvim-tree.api").tree.toggle()<CR>',
  { silent = true, noremap = true })
local tree_api = require("nvim-tree.api")
local tree_actions = {
  { name = "Create node",       handler = tree_api.fs.create, },
  { name = "Remove node",       handler = tree_api.fs.remove, },
  { name = "Trash node",        handler = tree_api.fs.trash, },
  { name = "Rename node",       handler = tree_api.fs.rename, },
  { name = "Fully rename node", handler = tree_api.fs.rename_sub, },
  { name = "Copy",              handler = tree_api.fs.copy.node, },
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
      actions.select_default:replace(function()
        local state = require("telescope.actions.state")
        local selection = state.get_selected_entry()
        actions.close(prompt_buffer_number)
        selection.value.handler(node)
      end)
      return true
    end,
  }
  require("telescope.pickers").new({ prompt_title = "Tree menu" }, default_options):find()
end
vim.keymap.set("n", "<C-P>", tree_actions_menu, { buffer = 0, noremap = true, silent = true })
