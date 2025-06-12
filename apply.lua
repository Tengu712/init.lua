local config_path = vim.fn.stdpath('config')
if config_path == '' then
  print('failed to get the config path of nvim.')
  return
end

-- コピー先の確認
print('Apply to', config_path, '(y/n)\n>> ')
local response = io.read()
if response ~= 'y' then
  return
end

local function is_windows()
  return vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1
end

local function n(a, b)
  if is_windows() then
    local res = string.gsub(a .. b, '/', '\\')
    return res
  else
    return vim.fs.normalize(a .. b)
  end
end

-- luaディレクトリ削除
config_lua_path = n(config_path, '/lua')
if vim.loop.fs_stat(config_lua_path) then
  vim.fn.delete(config_lua_path, 'rf')
end

local function job_handler(job)
  if job.code ~= 0 then
    print(('code: %d, stderr: %s'):format(job.code, job.stderr))
  end
end

local function copy(src, dst)
  if is_windows() then
    if vim.loop.fs_stat(src).type == 'file' then
      vim.system({ 'cmd', '/c', 'copy', src, dst }, { text = true }, job_handler):wait()
    else
      vim.system({ 'xcopy', src, dst, '/E', '/I', '/Y', '/Q' }, { text = true }, job_handler):wait()
    end
  else
    vim.system({ 'cp', '-r', src, dst }, { text = true }, job_handler):wait()
  end
end

-- コピー
copy(n(vim.fn.getcwd(), '/init.lua'), n(config_path,'/init.lua'))
copy(n(vim.fn.getcwd(), '/lua'), n(config_path, '/lua'))
