local config_path = vim.fn.stdpath('config')
if config_path == '' then
  print('failed to get the config path of nvim.')
end

local config_file = config_path .. '/init.lua'

print('Apply init.lua to', config_file, '(y/n)\n>> ')
local response = io.read()
if response ~= 'y' then
  return
end

local infile = io.open('./init.lua', 'r')
if not infile then
  print('failed to open ./init.lua')
end

local content = infile:read('*a')
infile:close()

local outfile = io.open(config_file, 'w')
if not outfile then
  print('failed to open', config_file)
end

outfile:write(content)
outfile:close()

print("successfully overwrote.")
