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
      -- 文字色はターミナルに任せる
      vim.cmd [[
        highlight DiffviewFilePanelFileName ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
        highlight DiffviewFilePanelPath     ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
        highlight DiffviewNormal            ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
      ]]
    end, { nargs = 0, desc = 'Diffviewを開く' })

    -- Diffviewを閉じるコマンド
    vim.api.nvim_create_user_command('CDIFF', function()
      vim.cmd('DiffviewClose')
    end, { nargs = 0, desc = 'Diffviewを開く' })
  end,
}
