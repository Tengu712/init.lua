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
