local ignores = {
  "--glob", "!.git/",
  "--glob", "!target/",
  "--glob", "!thirdparty/",
  "--glob", "!vcpkg/",
}

return {
  'nvim-telescope/telescope.nvim',
  branch = 'master',
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
