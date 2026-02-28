-- tree-sitter-cliをシステムにインストールしておく必要がある
-- :checkhealth nvim-treesitterとかで確認するといい
return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  opts = {
    ensure_installed = { 'commonlisp', 'lua', 'vim' },
  },
  config = function(_, opts)
    require('nvim-treesitter').setup(opts)
    vim.treesitter.language.register('commonlisp', 'lisp')
  end,
}
