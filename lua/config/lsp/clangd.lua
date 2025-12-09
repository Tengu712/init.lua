return {
  name = 'clangd',
  pattern = {'c', 'cpp', 'h', 'hpp'},
  root_dir = {'.clangd', 'compile_commands.json', 'compile_flags.txt', '.git'},
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
