-- 全ファイル共通の設定

-- 行数表示
vim.o.number = true

-- 折り返さない
vim.o.wrap = false

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

-- フォーマッタは使わない
vim.g.autoformat = false

-- すべてのファイルタイプでタブ設定を強制
vim.cmd('autocmd FileType * setlocal noexpandtab tabstop=4 softtabstop=4 shiftwidth=4')

-- 自動インデントを無効化
vim.cmd('autocmd FileType * setlocal noautoindent nosmartindent nocindent indentexpr= indentkeys=')

-- Rustでは自動インデントを有効化
vim.cmd('autocmd FileType rust setlocal autoindent smartindent indentexpr=v:lua.vim.lsp.formatexpr()')
