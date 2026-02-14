-- quitコマンドをフックして特殊ウィンドウしか残っていない場合はNeovim自体を終了させる
vim.api.nvim_create_autocmd('QuitPre', {
  callback = function()
    local cur_buf = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if buf ~= cur_buf then
        local bt = vim.api.nvim_get_option_value('buftype', { buf = buf })
        if bt == '' then
          if vim.fn.bufwinid(buf) ~= -1 then
            return
          end
        end
      end
    end
    vim.cmd [[only]]
  end,
})
