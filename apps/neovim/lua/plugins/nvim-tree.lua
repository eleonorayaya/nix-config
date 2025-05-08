function _G.nvim_tree_reveal_current_file()
  require("nvim-tree.api").tree.open({ find_file = true }) 
end

function _G.nvim_tree_toggle()
  require("nvim-tree.api").tree.toggle() 
end
