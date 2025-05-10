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
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup({})
    end
  },
  {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require('hop').setup {
        multi_windows = true,
      }
    end,
    keys = {
      {mode = '', '<Leader><Leader>', ':HopWord<CR>', desc = 'HopWordを起動する'},
      {mode = '', '<Leader>l', ':HopLine<CR>', desc = 'HopLineを起動する'},
    }
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'Tengu712/marks-popup.nvim'
  }
})

require('marks-popup').setup()

-------------------------------------------------------------------------------

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if vim.b.first_opened == nil then
      vim.b.first_opened = true

      vim.opt_local.list = true
      vim.opt_local.listchars = "tab:->,trail:~,nbsp:+"

      vim.opt_local.tabstop = 4
      vim.opt_local.softtabstop = 4

      vim.opt_local.autoindent = false
      vim.opt_local.smartindent = false
      vim.opt_local.smarttab = false
      vim.opt_local.indentexpr = ""
      vim.opt_local.indentkeys = ""
    end
  end,
})

vim.o.number = true
vim.o.clipboard = 'unnamedplus'

vim.keymap.set('i', 'jj', '<ESC>', { noremap = true, silent = true, desc = 'jjを打鍵してノーマルモードに戻る' })
vim.keymap.set('t', '<C-W>', '<C-\\><C-N>', { noremap = true, silent = true, desc = '端末モードを脱出する' })
vim.keymap.set('n', '<Leader>rt', ':belowright vertical terminal<CR>:vertical resize 60<CR>i', { noremap = true, silent = true, desc = '画面右側にターミナルを開く' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Telescopeでファイル検索を行う' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Telescopeでテキスト検索を行う' })
