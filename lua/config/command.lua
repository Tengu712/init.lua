-- Plugin非依存のコマンド定義群

vim.api.nvim_create_user_command('LF', function()
  local result = vim.fn.execute [[%s/\r\n/\r/ge]]
  if result:match('0 substitutions') or result == '' then
    print('no CRLF found')
  end
end, { nargs = 0, desc = 'ファイルのCRLFをLFに置換する' })

vim.api.nvim_create_user_command('STATUS', function()
  vim.cmd('set fileformat? fileencoding?')
end, { nargs = 0, desc = '本来statuslineに書かれる情報を確認する' })

vim.api.nvim_create_user_command('FMT', function()
  if vim.bo.filetype == 'rust' then
    vim.cmd('!cargo fmt')
  end
end, { nargs = 0, desc = '現在開いているバッファのファイルタイプに応じてフォーマットコマンドを実行する' })

vim.api.nvim_create_user_command('DARK', function()
  vim.o.background = 'dark'
  require('vscode').setup({})
  vim.cmd.colorscheme('vscode')
end, { nargs = 0, desc = 'ダークテーマに切り替える' })

vim.api.nvim_create_user_command('LIGHT', function()
  vim.o.background = 'light'
  require('solarized').setup({})
  vim.cmd.colorscheme('solarized')
end, { nargs = 0, desc = 'ライトテーマに切り替える' })
