local mode_color = {
  n       = { bg = '#0969b0' },
  i       = { bg = '#44b09a' },
  v       = { bg = '#e69d00' },
  V       = { bg = '#e69d00' },
  ['\22'] = { bg = '#e69d00' },
  r       = { bg = '#d93d3d' },
  R       = { bg = '#d93d3d' },
}

vim.api.nvim_create_autocmd({'ModeChanged', 'VimEnter'}, {
  callback = function()
    local mode = vim.fn.mode()
    local color = mode_color[mode] or mode_color.n
    vim.api.nvim_set_hl(0, 'Cursor',       color)
    vim.api.nvim_set_hl(0, 'CursorLineNr', color)
  end
})
