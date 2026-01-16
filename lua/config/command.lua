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

vim.api.nvim_create_user_command('X', function(opts)
  vim.cmd [[redir => g:tmp_cmd_output]]
  vim.cmd('silent! ' .. opts.args)
  vim.cmd [[
    redir END
    tabnew
    put =g:tmp_cmd_output
    1d_
    normal! gg
  ]]
  vim.api.nvim_del_var('tmp_cmd_output')
  local opt = vim.opt_local
  opt.buftype = 'nofile'
  opt.bufhidden = 'wipe'
  opt.swapfile = false
end, { nargs = '+', complete = 'command', desc = 'コマンド出力を新しいタブへ' })
