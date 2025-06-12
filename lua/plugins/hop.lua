return {
  'phaazon/hop.nvim',
  branch = 'v2',
  keys = {
    { mode = '', '<Leader><Leader>', ':HopWord<CR>', desc = 'HopWordを起動する' },
    { mode = '', '<Leader>l', ':HopLine<CR>', desc = 'HopLineを起動する' },
  },
  config = function()
    require('hop').setup({
      multi_windows = true,
    })
  end,
}
