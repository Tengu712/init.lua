return {
  'saghen/blink.cmp',
  version = '*',
  config = function()
    require('blink.cmp').setup({
      enabled = function()
        local filename = vim.fn.expand('%:t')
        return not vim.endswith(filename, '.md') and not vim.endswith(filename, '.mdx')
      end,
      completion = { documentation = { window = { border = "rounded" } } },
      keymap = {
        preset = 'none',
        ['<C-o>'] = { 'accept' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-i>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-m>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-n>'] = { 'scroll_documentation_down', 'fallback' },
        ['<Tab>'] = { 'fallback' },
        ['<S-Tab>'] = { 'fallback' },
      },
    })
  end,
}
