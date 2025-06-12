local config_path = vim.fn.stdpath('config')
if config_path == '' then
  print('failed to get the config path of nvim.')
  return
end

print('Apply to', config_path, '(y/n)\n>> ')
local response = io.read()
if response ~= 'y' then
  return
end

local function is_windows()
  return vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1
end

local function job_handler(job)
  if job.code ~= 0 then
    print(('code: %d, stderr: %s'):format(job.code, job.stderr))
  end
end

local function copy(src, dst)
  if is_windows() then
    vim.system({ 'cmd', '/c', 'copy', src, dst, '/Y' }, { text = true }, job_handler):wait()
  else
    vim.system({ 'cp', '-r', src, dst }, { text = true }, job_handler):wait()
  end
end

local function copy_dir(src, dst)
  if vim.loop.fs_stat(dst) then
    vim.fn.delete(dst, 'rf')
  end
  vim.fn.mkdir(dst)
  copy(src, dst)
end

local function n(a, b)
  if is_windows() then
    local res = string.gsub(a .. b, '/', '\\')
    return res
  else
    return vim.fs.normalize(a .. b)
  end
end

copy(n(vim.fn.getcwd(), '/init.lua'), n(config_path,'/init.lua'))
copy_dir(n(vim.fn.getcwd(), '/config'), n(config_path, '/config'))
copy_dir(n(vim.fn.getcwd(), '/plugins'), n(config_path, '/plugins'))
