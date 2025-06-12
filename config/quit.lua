-- バッファが通常のファイルか確認する関数
local function check_buffer(buf)
  return vim.api.nvim_buf_get_option(buf, 'buflisted')
    and vim.api.nvim_buf_get_option(buf, 'buftype') == ''
end

-- ユーザ定義コマンド
--
-- バッファを閉じ、もし通常ファイルバッファの数が1個以下ならnvimを終了させるため。
--
-- qから自動で呼び出すようにしておく。
-- qではバッファが閉じず、閉じたと思ったファイルが現れたり、空のバッファを開いたようになるのを防ぐため。
vim.api.nvim_create_user_command('BD', function(opts)
  -- !が続く場合
  local opt = ''
  if opts.bang then
    opt = '!'
  end

  -- 現在のバッファが通常のファイルでないなら強制終了
  if not check_buffer(vim.api.nvim_get_current_buf()) then
    vim.cmd('q' .. opt)
    return
  end

  -- 可視状態のバッファをカウント
  local visible_count = 0
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if check_buffer(buf) then
      visible_count = visible_count + 1
    end
  end

  -- 可視状態の通常ファイルバッファが1個以下ならnvimを強制終了
  -- そうでないなら現在のバッファをbdで強制的に閉じる
  if visible_count <= 1 then
    vim.cmd('qa' .. opt)
  else
    vim.cmd('bd' .. opt)
  end
end, { bang = true, nargs = '?', complete = 'buffer' })

-- 自然な終了のためにqをBDにマップする
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.cmd([[cnoreabbrev <expr> q  (getcmdtype() == ':' && getcmdline() ==# 'q')  ? 'BD' : 'q']])
    vim.cmd([[cnoreabbrev <expr> wq (getcmdtype() == ':' && getcmdline() ==# 'wq') ? 'w<CR>:BD' : 'wq']])
  end
})
