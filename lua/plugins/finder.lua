return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    -- setup
    require('telescope').setup({
      defaults = {
        file_ignore_patterns = {
          '.git',
          'target',
        },
      },
    })

    -- バインド
    vim.keymap.set('n', '<C-F>', require('telescope.builtin').find_files, { desc = 'Telescopeでファイル検索を行う' })
    vim.keymap.set('n', '<C-G>', require('telescope.builtin').live_grep, { desc = 'Telescopeでテキスト検索を行う' })
  end,
}
