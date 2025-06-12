vim.keymap.set('i', 'jj', '<ESC>', { noremap = true, silent = true, desc = 'jjを打鍵してノーマルモードに戻る' })
vim.keymap.set('t', '<C-W>', '<C-\\><C-N>', { noremap = true, silent = true, desc = '端末モードを脱出する' })
vim.keymap.set('n', '<Leader>h', ':noh<CR>', { noremap = true, silent = true, desc = 'ハイライトを削除' })
