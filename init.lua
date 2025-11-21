-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Configure leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install or load plugins
require('lazy').setup({
  require('plugins.theme'),
  require('plugins.term'),
  require('plugins.status'),
  require('plugins.diff'),
  require('plugins.diffview'),
  require('plugins.filer'),
  require('plugins.finder'),
  require('plugins.lsp'),
  require('plugins.completion'),
  require('plugins.hop'),
  require('plugins.mark'),
},
{ rocks = { enabled = false } })

-- Load config modules
require('config.common')
require('config.keymap')
require('config.lf')
require('config.move')
require('config.neovide')
require('config.quit')

-- Apply colorscheme
vim.cmd('colorscheme vscode')
