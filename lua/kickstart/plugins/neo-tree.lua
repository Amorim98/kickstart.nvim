-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    default_component_configs = {
      indent = {
        indent_size = 2,
        padding = 1,
        with_markers = true,
        indent_marker = '│',
        last_indent_marker = '└',
        with_highlights = true,
        highlight = 'NeoTreeIndentMarker',
      },
      icon = {
        folder_closed = '󰉋',
        folder_open = '󰉖',
        folder_empty = '󰜌',
        default = '󰈙',
        highlight = 'NeoTreeFileIcon',
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = 'NeoTreeFileName',
      },
      git_status = {
        symbols = {
          added = '',
          modified = '',
          deleted = '✖',
          renamed = '󰁕',
          untracked = '󰋽',
          ignored = '󰀌',
          unstaged = '󰄱',
          staged = '󰄭',
          conflict = '󰅜',
        },
      },
    },
    window = {
      position = 'left',
      width = 35,
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ['\\'] = 'close_window',
        ['<space>'] = {
          'toggle_node',
          nowait = false,
        },
        ['<2-LeftMouse>'] = 'open',
        ['<cr>'] = 'open',
        ['<esc>'] = 'cancel',
        ['P'] = { 'toggle_preview', config = { use_float = true } },
        ['l'] = 'focus_preview',
        ['S'] = 'open_split',
        ['s'] = 'open_vsplit',
        ['t'] = 'open_tabnew',
        ['w'] = 'open_with_window_picker',
        ['C'] = 'close_node',
        ['z'] = 'close_all_nodes',
        ['a'] = {
          'add',
          config = {
            show_path = 'none',
          },
        },
        ['A'] = 'add_directory',
        ['d'] = 'delete',
        ['r'] = 'rename',
        ['y'] = 'copy_to_clipboard',
        ['x'] = 'cut_to_clipboard',
        ['p'] = 'paste_from_clipboard',
        ['c'] = 'copy',
        ['m'] = 'move',
        ['q'] = 'quit_tree',
        ['R'] = 'refresh',
        ['?'] = 'show_help',
        ['<'] = 'prev_source',
        ['>'] = 'next_source',
        ['i'] = 'show_file_details',
      },
    },
    default_expand_all = false,
    expand_folder_to_load = false,
    enable = {
      directory_recurse = false,
    },
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
        hide_by_name = {
          'node_modules',
          '.git',
          '.DS_Store',
          'thumbs.db',
        },
        never_show = {
          '.git',
          'node_modules',
        },
      },
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      group_empty_dirs = false,
      use_libuv_file_watcher = true,
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
    event_handlers = {
      {
        event = 'file_opened',
        handler = function(_)
          require('neo-tree.command').execute({ action = 'close' })
        end,
      },
      {
        event = 'neo_tree_window_after_open',
        handler = function(args)
          vim.wo.signcolumn = 'auto'
        end,
      },
    },
  },
}
