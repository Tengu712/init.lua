-- Rustファイルを開いたときに次の定義ブロックをfoldする
--
-- * trait
-- * struct
-- * enum
-- * fn
vim.api.nvim_create_autocmd("FileType", {
  pattern = "rust",
  callback = function()
    vim.opt_local.foldmethod = "manual"

    vim.defer_fn(function()
      local bufnr = vim.api.nvim_get_current_buf()
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

      local patterns = {
        "^%s*pub trait ",
        "^%s*pub struct ",
        "^%s*pub enum ",
        "^%s*pub fn ",
        "^%s*pub unsafe fn ",
        "^%s*pub async fn ",
        "^%s*trait ",
        "^%s*struct ",
        "^%s*enum ",
        "^%s*fn ",
        "^%s*unsafe fn ",
        "^%s*async fn ",
      }

      local save_cursor = vim.api.nvim_win_get_cursor(0)

      for i, line in ipairs(lines) do
        for _, pattern in ipairs(patterns) do
          if line:match(pattern) then
            vim.api.nvim_win_set_cursor(0, {i, 0})

            -- 10行先までに ; か { があるか探す
            --
            -- WARN: コメントを考慮していないので壊れうる。
            local semicolon_pos = vim.fn.search(";", "cnW", i + 10)
            local brace_pos = vim.fn.search("{", "cnW", i + 10)

            -- { がない・あるいは ; が先に見つかったらスキップ
            if brace_pos == 0 or (semicolon_pos > 0 and semicolon_pos < brace_pos) then
              break
            end

            -- { に移動して対になる } の位置を取得
            vim.api.nvim_win_set_cursor(0, {i, 0})
            vim.fn.search("{", "cW")
            vim.cmd("silent! normal! %")
            local end_pos = vim.api.nvim_win_get_cursor(0)

            -- fold
            vim.api.nvim_win_set_cursor(0, {i, 0})
            vim.cmd(string.format("silent! %d,%dfold", i, end_pos[1]))
            break
          end
        end
      end

      vim.api.nvim_win_set_cursor(0, save_cursor)
    end, 50)
  end,
})
