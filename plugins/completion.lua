return {
  'saghen/blink.cmp',
  version = '*',
  config = function()
    require('blink.cmp').setup({
      completion = { documentation = { window = { border = "rounded" } } },
      keymap = {
        preset = 'none',
        ['<C-o>'] = { 'accept' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-i>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-m>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-n>'] = { 'scroll_documentation_down', 'fallback' },
      },
    })
  end,
}
