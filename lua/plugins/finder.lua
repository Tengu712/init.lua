local ignores = {
  "--glob", "!.git/",
  "--glob", "!target/",
  "--glob", "!thirdparty/",
}

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    defaults = {
      vimgrep_arguments = vim.list_extend({
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
      }, ignores),
    },
    pickers = {
      find_files = {
        find_command = vim.list_extend({
          "rg",
          "--files",
          "--hidden",
        }, ignores),
      },
    },
  },
  keys = {
    { '<C-F>', function() require('telescope.builtin').find_files() end },
    { '<C-G>', function() require('telescope.builtin').live_grep() end },
  },
}
