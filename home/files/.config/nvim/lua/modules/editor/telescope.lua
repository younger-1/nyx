if not pcall(require, 'telescope') then
  return
end

local load_plugins = function(names)
  for _, name in ipairs(names) do
    if not packer_plugins[name].loaded then
      vim.cmd('packadd ' .. name)
    end
  end
end

load_plugins({'popup.nvim', 'plenary.nvim'})

local actions    = require('telescope.actions')
local previewers = require('telescope.previewers')
local sorters    = require('telescope.sorters')
local themes     = require('telescope.themes')
local nnoremap   = vim.keymap.nnoremap

require('telescope').setup {
  defaults = {
    prompt_prefix = '❯ ',
    selection_caret = '❯ ',


    winblend = 0,
    preview_cutoff = 120,

    layout_strategy = 'horizontal',
    layout_defaults = {
      horizontal = {
        width_padding = 0.1,
        height_padding = 0.1,
        preview_width = 0.6,
      },
      vertical = {
        width_padding = 0.05,
        height_padding = 1,
        preview_height = 0.5,
      }
    },

    selection_strategy = "reset",
    sorting_strategy = "descending",
    scroll_strategy = "cycle",
    prompt_position = "bottom",
    color_devicons = true,

    mappings = {
      i = {
        ["<C-x>"] = false,
        ["<C-s>"] = actions.select_horizontal,

        -- Experimental
        -- ["<tab>"] = actions.toggle_selection,

        -- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        -- ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
    },

    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰'},

    file_sorter = sorters.get_fzy_sorter,

    file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
  },

  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
  },
}

require('telescope').load_extension('fzy_native')

nnoremap { '<leader>ff', [[<cmd>Telescope find_files<cr>]], silent=true }
vim.which_leader['f'].f = 'files'

nnoremap { '<leader>fr', [[<cmd>Telescope live_grep<cr>]], silent=true }
vim.which_leader['f'].r = 'grep'

nnoremap { '<leader>fs', [[<cmd>Telescope lsp_workspace_symbols<cr>]], silent=true }
vim.which_leader['f'].s = 'symbols'

nnoremap { '<leader>fb', [[<cmd>Telescope buffers<cr>]], silent=true }
vim.which_leader['f'].b = 'buffers'

nnoremap { '<leader>fB', [[<cmd>Telescope builtin<cr>]], silent=true }
vim.which_leader['f'].B = 'builtins'

nnoremap { '<leader>fh', [[<cmd>Telescope help_tags<cr>]], silent=true }
vim.which_leader['f'].h = 'help'

nnoremap { '<leader>fe', [[<cmd>Telescope file_browser<cr>]], silent=true }
vim.which_leader['f'].e = 'file-explorer'

nnoremap { '<leader>fq', [[<cmd>Telescope quickfix<cr>]], silent=true }
vim.which_leader['f'].q = 'quickfix'

nnoremap { '<leader>fQ', [[<cmd>Telescope loclist<cr>]], silent=true }
vim.which_leader['f'].Q = 'locallist'

nnoremap { '<leader>fgb', [[<cmd>Telescope git_branches<cr>]], silent=true }
nnoremap { '<leader>fgc', [[<cmd>Telescope git_commits<cr>]], silent=true }
nnoremap { '<leader>fgl', [[<cmd>Telescope git_bcommits<cr>]], silent=true }
nnoremap { '<leader>fgs', [[<cmd>Telescope git_status<cr>]], silent=true }
vim.which_leader['f'].g = {
  name = '+git',
  b = 'branches',
  c = 'commits',
  l = 'local-commits',
  s = 'status',
}