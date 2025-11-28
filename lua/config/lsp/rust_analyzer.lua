vim.lsp.config['rust-analyzer'] = {
  capabilities = require('blink.cmp').get_lsp_capabilities(),

  filetypes = {'rust'},

  root_markers = {'Cargo.toml', '.git'},

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

vim.lsp.enable('rust-analyzer')
