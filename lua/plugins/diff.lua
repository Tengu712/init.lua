vim.keymap.set('n', '<leader>d', function()
  require('mini.diff').toggle_overlay()
end, { desc = 'diffを表示する' })

return {
  'echasnovski/mini.diff',
  version = '*',
  opts = { view = { style = "sign" } },
}
