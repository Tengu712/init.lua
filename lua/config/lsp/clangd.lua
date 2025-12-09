vim.api.nvim_create_autocmd('FileType', {
  pattern = {'c', 'cpp', 'h', 'hpp'},
  callback = function(args)
    local root_dir = vim.fs.root(args.buf, {'.clangd', 'compile_commands.json', 'compile_flags.txt', '.git'})

    -- root_dirが相対パスなら起動しない
    -- NOTE: diffview.nvimはroot_dirが.になり、これを許すと多重起動に繋がる
    if not root_dir or root_dir:match('^%.') then
      return
    end

    -- 同じroot_dirを持つLSPを起動しない
    local clients = vim.lsp.get_clients({ name = 'clangd' })
    for _, client in ipairs(clients) do
      if client.config.root_dir == root_dir then
        return
      end
    end

    vim.lsp.start {
      name = 'clangd',
      cmd = {
        'clangd',
        '--background-index',
        '--clang-tidy',
        '--completion-style=detailed',
        '--function-arg-placeholders',
        '--fallback-style=llvm',
        '--header-insertion=never',
      },
      root_dir = root_dir,
      capabilities = require('blink.cmp').get_lsp_capabilities(),
      on_attach = on_attach,
    }
  end,
})
