vim.lsp.config['clangd'] = {
  capabilities = require('blink.cmp').get_lsp_capabilities(),

  filetypes = {'c', 'h', 'cpp', 'hpp'},

  root_markers = {{'.clangd', 'compile_commands.json', 'compile_flags.txt'}, '.git'},

  cmd = {
    'clangd',
    '--background-index',
    '--clang-tidy',
    '--completion-style=detailed',
    '--function-arg-placeholders',
    '--fallback-style=llvm',
    '--header-insertion=never',
  },

  init_options = {
    usePlaceholders = true,
    clangdFileStatus = true,
    completeUnimported = false,
  },

  settings = {
    clangd = {
      semanticHighlighting = true,
    },
  },
}

vim.lsp.enable('clangd')
