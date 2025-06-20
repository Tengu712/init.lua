return {
  'sindrets/diffview.nvim',
  opts = {
    keymaps = {
      disable_defaults = true,
    },
    enhanced_diff_hl = true,
  },
  config = function()
    -- Diffviewを開くコマンド
    vim.api.nvim_create_user_command('DIFF', function()
      vim.cmd('DiffviewOpen')
    end, { nargs = 0, desc = 'Diffviewを開く' })

    -- Diffviewを閉じるコマンド
    vim.api.nvim_create_user_command('CDIFF', function()
      vim.cmd('DiffviewClose')
    end, { nargs = 0, desc = 'Diffviewを開く' })
  end,
}
