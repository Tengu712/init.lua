-- 全ファイル共通の設定

-- 行数表示
vim.o.number = true

-- カーソルラインへのハイライトをできるように
vim.o.cursorline = true

-- 折り返さない
vim.o.wrap = false

-- 改行コードはLF
vim.o.fileformat = 'unix'
vim.o.fileformats = 'unix,dos'

-- LSPが効いていなくても行数の左にGit diff用の空間を開ける
vim.o.signcolumn = 'yes'

-- クリップボードを使う
vim.o.clipboard = 'unnamedplus'

-- タブや行末の空白等に色を付ける
vim.o.list = true
vim.o.listchars = 'tab:>-,trail:~,nbsp:+'

-- タブ幅は4
vim.o.tabstop = 4
vim.o.softtabstop = 4

-- 行頭のタブ入力はインデント
vim.o.smarttab = true

-- タブ入力はタブ入力
vim.o.expandtab = false

-- statusline非表示
vim.o.laststatus = 0

-- フォーマッタは使わない
vim.g.autoformat = false

-- カスタム fold 表示
_G.custom_fold_text = function()
  local line = vim.fn.getline(vim.v.foldstart)
  local line_count = vim.v.foldend - vim.v.foldstart + 1

  local width = vim.fn.winwidth(0)
  local number_width = vim.wo.number and vim.wo.numberwidth or 0
  local sign_width = vim.wo.signcolumn == 'yes' and 2 or 0
  local fold_width = vim.wo.foldcolumn
  local available_width = width - number_width - sign_width - fold_width

  local text = line:gsub('\t', string.rep(' ', vim.bo.tabstop))
  local suffix = string.format('%d lines', line_count)
  local padding_width = available_width - vim.fn.strdisplaywidth(text) - vim.fn.strdisplaywidth(suffix)
  local padding = string.rep(' ', math.max(0, padding_width))

  return text .. padding .. suffix
end
vim.o.foldtext = 'v:lua.custom_fold_text()'

-- すべてのファイルタイプでタブ設定を強制
vim.cmd('autocmd FileType * setlocal noexpandtab tabstop=4 softtabstop=4 shiftwidth=4')

-- 自動インデントを無効化
vim.cmd('autocmd FileType * setlocal noautoindent nosmartindent nocindent indentexpr= indentkeys=')

-- Rustでは自動インデントを有効化
vim.cmd('autocmd FileType rust setlocal autoindent smartindent indentexpr=v:lua.vim.lsp.formatexpr() expandtab tabstop=4 softtabstop=4 shiftwidth=4')

-- Swiftでは自動インデントを有効化
vim.cmd('autocmd FileType swift setlocal autoindent smartindent indentexpr=v:lua.vim.lsp.formatexpr() expandtab tabstop=4 softtabstop=4 shiftwidth=4')

-- Lisp/Common Lispではスペースを使用し、自動インデントを有効化
vim.cmd('autocmd FileType lisp setlocal autoindent smartindent expandtab tabstop=2 softtabstop=2 shiftwidth=2')
