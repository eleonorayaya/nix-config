function _G.comment_toggle_line()
  require("Comment.api").toggle.linewise()
end

function _G.comment_toggle_selection()
  local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
  vim.api.nvim_feedkeys(esc, "nx", false)
  require("Comment.api").toggle.linewise(vim.fn.visualmode())
end
