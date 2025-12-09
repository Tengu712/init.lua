return {
  name = 'rust-analyzer',
  pattern = {'rust'},
  root_dir = {'Cargo.toml', '.git'},
  cmd = {'rust-analyzer'},
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = {
        enable = true,
        command = 'clippy',
        extraArgs = {'--no-deps'},
      },
      lens = { enable = false },
    },
  },
  flags = {
    debounce_text_changes = 2000,
  },
}
