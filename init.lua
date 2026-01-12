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
  require('plugins.term'),
  require('plugins.diff'),
  require('plugins.diffview'),
  require('plugins.filer'),
  require('plugins.finder'),
  require('plugins.completion'),
  require('plugins.hop'),
  require('plugins.mark'),
},
{ rocks = { enabled = false } })

-- Load config modules
require('config.command')
require('config.common')
require('config.keymap')
require('config.lsp')
require('config.move')
require('config.neovide')
require('config.theme')
require('config.quit')

-- Additional settings
local add_path = vim.fn.stdpath('config') .. '/add.lua'
if vim.fn.filereadable(add_path) == 1 then
  dofile(add_path)
end
