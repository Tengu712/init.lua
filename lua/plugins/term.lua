return {
  'akinsho/toggleterm.nvim',
  config = function()
    -- setup
    require('toggleterm').setup({
      open_mapping = '<c-t>',
      direction = 'float',
    })

    -- 0-9トグル
    for i = 1, 9 do
      vim.keymap.set('n', '<C-' .. i .. '>', ':ToggleTerm' .. i .. '<CR>', { noremap = true, silent = true, desc = i .. '番目のターミナルを開く' })
      vim.api.nvim_create_user_command('TT' .. i, function()
        vim.cmd(':ToggleTerm' .. i)
      end, {  desc = '番目のターミナルを開く' })
    end

    -- ユーザ定義コマンド
    --
    -- 開いているすべてのターミナルを強制終了する。
    -- ターミナルがスタックした時用。
    vim.api.nvim_create_user_command('KILLTERMS', function()
      local terms = require('toggleterm.terminal')
      local flag = false
      for _, term in pairs(terms.get_all()) do
        if term:is_open() then
          term:shutdown()
          flag = true
          print("Quit terminal #" .. term.id)
        end
      end
      if flag then
        print("The above terminals killed.")
      else
        print("No terminal is open.")
      end
    end, { desc = '開いているすべてのターミナルを強制終了する' })
  end,
}
