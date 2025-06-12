local function move(rdst)
  local cur = vim.fn.expand('%:p')
  local cur_dir = vim.fn.expand('%:p:h')

  -- 確認
  if cur == '' or vim.fn.filereadable(cur) == 0 then
    print("Error: No file is currently open or file doesn't exist.")
    return
  end

  -- 相対パスから絶対パスへ
  local dst
  if vim.fn.fnamemodify(rdst, ':p') == rdst then
    dst = rdst
  else
    dst = vim.fn.resolve(cur_dir .. '/' .. rdst)
  end

  -- 移動先ディレクトリ作成
  local dst_dir = vim.fn.fnamemodify(dst, ':h')
  if vim.fn.isdirectory(dst_dir) == 0 then
    vim.fn.mkdir(dst_dir, 'p')
  end

  -- コピー
  vim.cmd('saveas ' .. vim.fn.fnameescape(dst))

  -- 削除
  if vim.fn.delete(cur) == 0 then
    print("Moved: " .. cur .. " -> " .. dst)
  else
    print("Warning: Failed to delete original file: " .. cur)
  end
end

-- ユーザ定義コマンド
--
-- 現在開いているファイルを移動する。
-- 名前の変更が主な目的。
vim.api.nvim_create_user_command('MOVE', function(opts)
  if opts.args == '' then
    print("Error: :MOVE <target-path>")
    return
  end
  move(opts.args)
end, {
  nargs = 1,
  complete = 'file',
  desc = '現在開いているファイルを移動する'
})
