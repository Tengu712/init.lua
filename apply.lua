-- 設定ファイル群をconfig pathにコピーするスクリプト
--
-- EXAMPLE:
--   nvim -l apply.lua

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

local function job_handler(job)
  if job.code ~= 0 then
    print(('code: %d, stderr: %s'):format(job.code, job.stderr))
  end
end

local config_path = vim.fn.stdpath('config')
if config_path == '' then
  print('failed to get the config path of nvim.')
  return
end

local init_lua_src = n(vim.fn.getcwd(), '/init.lua')
local init_lua_dst = n(config_path, '/init.lua')
local lua_src      = n(vim.fn.getcwd(), '/lua')
local lua_dst      = n(config_path, '/lua')

local cmds = is_windows() and {
  { 'cmd', '/c', 'del', init_lua_dst },
  { 'cmd', '/c', 'rd', '/S', '/Q', lua_dst },
  { 'cmd', '/c', 'copy', init_lua_src, init_lua_dst },
  { 'cmd', '/c', 'xcopy', '/E', '/I', '/Y', '/Q', lua_src, lua_dst },
} or {
  { 'rm', init_lua_dst },
  { 'rm', '-rf', lua_dst },
  { 'cp', init_lua_src, init_lua_dst },
  { 'cp', '-r', lua_src, lua_dst },
}

for _, cmd in pairs(cmds) do
  vim.system(cmd, { text = true }, job_handler):wait()
end

print("succeeded to write configs to ", config_path)
