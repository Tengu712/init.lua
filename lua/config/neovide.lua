if vim.g.neovide then
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_refresh_rate_idle = 1

  -- NOTE: neovideはデフォルトでFira Code Nerd Fontを使う。
  --       これにあやかりたいが、
  --       バンドルされたフォントはguifontとして指定できない上に、
  --       config.tomlでフォントサイズを指定しても効果がない。
  --       なので、スケールを変えることで対応する。
  local function change_scale(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end

  vim.api.nvim_create_user_command('EX', function()
    change_scale(1.1)
  end, { nargs = 0, desc = '画面を1.1倍する' })

  vim.api.nvim_create_user_command('RE', function()
    change_scale(0.9)
  end, { nargs = 0, desc = '画面を0.9倍する' })
end
