return {
  {
    'obsidian-nvim/obsidian.nvim',
    version = '*',
    lazy = true,
    cmd = { 'Obsidian' },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      ui = {
        enable = true,
      },
      legacy_commands = false,
      workspaces = {
        {
          name = 'personal',
          path = '/mnt/c/dev/notes',
        },
      },
    },
  },
}
