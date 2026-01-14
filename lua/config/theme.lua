-- ターミナルに合わせる
vim.cmd [[
  highlight Normal       ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
  highlight NonText      ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
  highlight SignColumn   ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
  highlight EndOfBuffer  ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
  highlight Cursor       ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
  highlight lCursor      ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
  highlight TermCursor   ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
  highlight TermCursorNC ctermfg=NONE ctermbg=NONE guifg=NONE guibg=NONE
]]

-- テーマによらない文字色を指定
vim.cmd [[
  highlight LineNr       cterm=NONE ctermfg=244 gui=NONE guifg=#808080
  highlight CursorLineNr cterm=NONE ctermfg=255 gui=NONE guifg=#FFFFFF
  highlight SpecialKey   cterm=NONE ctermfg=244 gui=NONE guifg=#808080
  highlight Whitespace   cterm=NONE ctermfg=244 gui=NONE guifg=#808080
]]

local mode_color = {
  n       = { bg = '#0969b0' },
  i       = { bg = '#44b09a' },
  v       = { bg = '#e69d00' },
  V       = { bg = '#e69d00' },
  ['\22'] = { bg = '#e69d00' },
  r       = { bg = '#d93d3d' },
  R       = { bg = '#d93d3d' },
}

-- モード変更時に色を変える
vim.api.nvim_create_autocmd({'ModeChanged', 'VimEnter'}, {
  callback = function()
    local mode = vim.fn.mode()
    local color = mode_color[mode] or mode_color.n
    vim.cmd(string.format('highlight CursorLineNr guibg=%s', color.bg))
  end
})
