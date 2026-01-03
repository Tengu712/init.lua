return {
  'maxmx03/solarized.nvim',
  lazy = false,
  priority = 1001,
  config = function()
    vim.o.termguicolors = true
    vim.o.background = 'light'
    require('solarized').setup({})
    vim.cmd.colorscheme('solarized')
  end,
}
