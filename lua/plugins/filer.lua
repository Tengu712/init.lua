function find_neo_tree_window()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft  = vim.api.nvim_buf_get_option(buf, 'filetype')
    if ft == 'neo-tree' then
      return win
    end
  end
  return nil
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  lazy = false,
  config = function()
    -- ユーザ定義コマンド
    vim.api.nvim_create_user_command('NT', function()
      vim.cmd [[Neotree toggle]]
      local win = find_neo_tree_window()
      if win then
        vim.api.nvim_win_set_width(win, math.floor(vim.o.columns * 0.2))
      end
    end, { desc = 'Neotreeをトグルで開く' })
  end,
}
