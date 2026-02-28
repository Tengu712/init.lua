return {
  "kovisoft/slimv",
  ft = { "lisp" },
  init = function()
    vim.g.slimv_swank_port = 4005
    vim.g.slimv_swank_host = "localhost"
    vim.g.slimv_swank_cmd = '!echo "SWANK server already running"'

    vim.g.slimv_repl_split = 4
    vim.g.slimv_indent_disable = 1
  end,
}
