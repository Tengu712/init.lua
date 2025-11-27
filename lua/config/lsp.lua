-- 外観
vim.diagnostic.config({
  update_in_insert = true,
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticLineNrError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticLineNrWarn',
      [vim.diagnostic.severity.INFO] = 'DiagnosticLineNrInfo',
      [vim.diagnostic.severity.HINT] = 'DiagnosticLineNrHint',
    },
    linehl = {},
  },
  underline = true,
  severity_sort = true,
  float = { border = 'rounded' },
})

-- カラースキーム
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  group = vim.api.nvim_create_augroup('MyDiagnosticHighlights', { clear = true }),
  callback = function()
    vim.api.nvim_set_hl(0, 'DiagnosticLineNrError', { fg = '#FF0000', bold = true })
    vim.api.nvim_set_hl(0, 'DiagnosticLineNrWarn',  { fg = '#FFA500', bold = true })
    vim.api.nvim_set_hl(0, 'DiagnosticLineNrInfo',  { fg = '#00FFFF', bold = true })
    vim.api.nvim_set_hl(0, 'DiagnosticLineNrHint',  { fg = '#00FF00', bold = true })
  end,
})

-- バインド
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { noremap = true, silent = true, desc = 'コード解析メッセージを表示' })
local on_attach = function(client, bufnr)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true, buffer = bufnr, desc = 'ホバー表示' })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true, buffer = bufnr, desc = '定義元へジャンプ' })
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, { noremap = true, silent = true, buffer = bufnr, desc = '参照元を一覧表示' })
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { noremap = true, silent = true, buffer = bufnr, desc = '実装へジャンプ' })
end

-- コマンド
vim.api.nvim_create_user_command('LSP', function()
  vim.tbl_map(
    function(c)
      print(c.name)
    end,
    vim.lsp.get_clients()
  )
end, { nargs = 0, desc = '現在のLSPの情報をprintする' })

-- 各言語設定
require('config.lsp.clangd')



-- TODO: 以降lspディレクトリ下に移す

-- 補完用
local capabilities = require('blink.cmp').get_lsp_capabilities()

-- Lua
vim.lsp.config('lua_ls', {
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Rust
vim.lsp.config('rust_analyzer', {
  capabilities = capabilities,
  on_attach = on_attach,
  debounce_text_changes = 2000,
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
})

-- C/C++

-- Swift
vim.lsp.config('sourcekit', {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { 'swift' },
  cmd = { 'xcrun', '--toolchain', 'swift', 'sourcekit-lsp' },
  root_markers = {'Package.swift', '*.xcodeproj', '*.xcworkspace', 'buildServer.json', 'compile_commands.json'},
})

-- Java
local jdtls_plugins = os.getenv('JDTLS_PLUGINS')
local jdtls_config = os.getenv('JDTLS_CONFIG')
if jdtls_plugins and jdtls_config then
  vim.lsp.config('jdtls', {
    capabilities = capabilities,
    cmd = {
      'java',
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Xms1g',
      '-Xmx2G',
      '--add-modules=ALL-SYSTEM',
      '--add-opens', 'java.base/java.util=ALL-UNNAMED',
      '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
      '-jar', jdtls_plugins .. '/org.eclipse.equinox.launcher_1.7.0.v20250424-1814.jar',
      '-configuration', jdtls_config,
      '-data', vim.fn.expand('~/.cache/jdtls/workspace'),
    },
    root_dir = lspconfig.util.root_pattern('.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'),
    filetypes = { 'java' },
    settings = {
      java = {
        eclipse = { downloadSources = true },
        configuration = { updateBuildConfiguration = 'interactive' },
        maven = { downloadSources = true },
        format = { enabled = true },
      },
    },
  })
end
