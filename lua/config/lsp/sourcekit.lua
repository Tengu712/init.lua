return {
  name = 'sourcekit',
  pattern = {'swift'},
  root_dir = {
    'buildServer.json',
    '*.xcodeproj',
    '*.xcworkspace',
    'Package.swift',
    '.git',
  },
  cmd = {'sourcekit-lsp'},
}
