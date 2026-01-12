-- config pathを確認するためのスクリプト
--
-- EXAMPLE:
--   nvim -l check-config-path.lua

local config_path = vim.fn.stdpath('config')
if config_path == '' then
  print('failed to get the config path of nvim.')
  return
end

print(config_path)
