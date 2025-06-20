vim.api.nvim_create_user_command('LF', function()
  vim.cmd([[%s/\r\n/\r/]])
end, { nargs = 0, desc = 'ファイルのCRLFをLFに置換する' })
