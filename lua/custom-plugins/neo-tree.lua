vim.pack.add {{
  src = gh "nvim-neo-tree/neo-tree.nvim",
  version = vim.version.range('3'),
},
gh "nvim-lua/plenary.nvim",
gh "MunifTanjim/nui.nvim",
gh "nvim-tree/nvim-web-devicons",
{
  src = gh "s1n7ax/nvim-window-picker",
  version = vim.version.range('2'),
},
}

vim.keymap.set('n', '<leader>e', '<Cmd>Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })

require('neo-tree').setup {
  filesystem = {
    window = {
      mappings = {
        ['<Esc>'] = 'close_window',
      },
    },
  },
}
require("window-picker").setup({})

