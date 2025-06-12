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

vim.fn.mkdir(config_path .. '/config', 'p')
vim.fn.mkdir(config_path .. '/plugins', 'p')

local function is_windows()
  return vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1
end

local function job_handler(job)
  if job.code ~= 0 then
    print(('code: %d, stderr: %s'):format(job.code, job.stderr))
  end
end

local function remove(trg)
  if is_windows() then
    vim.system({ 'rmdir', '/S', '/Q', trg }, { text = true }, job_handler):wait()
  else
    vim.system({ 'rm', '-rf', trg }, { text = true }, job_handler):wait()
  end
end

local function copy(src, dst)
  if is_windows() then
    vim.system({ 'xcopy', '/Y', src, dst }, { text = true }, job_handler):wait()
  else
    vim.system({ 'cp', '-r', src, dst }, { text = true }, job_handler):wait()
  end
end

local function copy_config(src, dst)
  if vim.loop.fs_stat(dst) then
    remove(dst)
  end
  copy(src, dst)
end

copy_config('./init.lua', config_path .. '/init.lua')
copy_config('./config', config_path .. '/config')
copy_config('./plugins', config_path .. '/plugins')
