return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  lazy = false,
  opts = {
    window = { width = '15%' },
  },
  config = function()
    -- ユーザ定義コマンド
    vim.api.nvim_create_user_command('NT', function()
      vim.cmd('Neotree toggle')
    end, { desc = 'Neotreeをトグルで開く' })
  end,
}
