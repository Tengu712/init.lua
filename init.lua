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
    'Mofiqul/vscode.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('vscode').setup({})
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
      })
    end
  },
  {
    'echasnovski/mini.diff',
    version = '*',
    opts = {
      view = {
        style = "sign"
      }
    }
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.diagnostic.config({
        update_in_insert = true,
        virtual_text = false,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
          },
          numhl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticLineNrError",
            [vim.diagnostic.severity.WARN] = "DiagnosticLineNrWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticLineNrInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticLineNrHint",
          },
          linehl = {},
        },
        underline = true,
        severity_sort = true,
        float = { border = "rounded" }
      })
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { noremap = true, silent = true })
      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup({})
      lspconfig.rust_analyzer.setup({
        debounce_text_changes = 2000,
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = {
              enable = true,
              command = "clippy",
              extraArgs = {"--no-deps"}
            },
            lens = {
              enable = false
            }
          }
        }
      })
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
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup({
        defaults = {
          file_ignore_patterns = {
            '.git',
            'target'
          }
        }
      })
    end
  },
  {
    'Tengu712/marks-popup.nvim',
    config = function()
      require('marks-popup').setup()
    end
  }
},
{ rocks = { enabled = false } })

-------------------------------------------------------------------------------

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  group = vim.api.nvim_create_augroup("MyDiagnosticHighlights", { clear = true }),
  callback = function()
    vim.api.nvim_set_hl(0, "DiagnosticLineNrError", { fg = "#FF0000", bold = true })
    vim.api.nvim_set_hl(0, "DiagnosticLineNrWarn",  { fg = "#FFA500", bold = true })
    vim.api.nvim_set_hl(0, "DiagnosticLineNrInfo",  { fg = "#00FFFF", bold = true })
    vim.api.nvim_set_hl(0, "DiagnosticLineNrHint",  { fg = "#00FF00", bold = true })
  end,
})
vim.cmd('colorscheme vscode')

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    if vim.b.first_opened == nil then
      vim.b.first_opened = true

      vim.opt_local.list = true
      vim.opt_local.listchars = 'tab:->,trail:~,nbsp:+'

      vim.opt_local.tabstop = 4
      vim.opt_local.softtabstop = 4

      vim.opt_local.autoindent = false
      vim.opt_local.smartindent = false
      vim.opt_local.smarttab = false
      vim.opt_local.indentexpr = ''
      vim.opt_local.indentkeys = ''
    end
  end,
})

vim.o.number = true
vim.o.wrap = false
vim.o.signcolumn = 'yes'
vim.o.clipboard = 'unnamedplus'

vim.keymap.set('i', 'jj', '<ESC>', { noremap = true, silent = true, desc = 'jjを打鍵してノーマルモードに戻る' })
vim.keymap.set('t', '<C-W>', '<C-\\><C-N>', { noremap = true, silent = true, desc = '端末モードを脱出する' })
vim.keymap.set('n', '<Leader>rt', ':belowright vertical terminal<CR>:vertical resize 60<CR>i', { noremap = true, silent = true, desc = '画面右側にターミナルを開く' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = 'Telescopeでファイル検索を行う' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = 'Telescopeでテキスト検索を行う' })
