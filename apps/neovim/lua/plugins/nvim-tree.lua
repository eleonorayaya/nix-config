function _G.nvim_tree_reveal_current_file()
  require("nvim-tree.api").tree.open({ find_file = true })
end

function _G.nvim_tree_toggle()
  require("nvim-tree.api").tree.toggle()
end

-- recommended settings from nvim-tree documentation
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Fix tree state when restoring a session where the tree was open
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "NvimTree*",
  callback = function()
		local api = require("nvim-tree.api")
		local view = require("nvim-tree.view")

    if not view.is_visible() then
      api.tree.open()
    end
  end,
})
