function _G.harpoon_add_file()
  local n = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())

  if string.match(n, "NvimTree") then
    return
  end

  require("harpoon.mark").add_file()
end

function _G.harpoon_get_paths(files)
  local paths = {}

  for _, item in ipairs(files.items) do
    table.insert(paths, item.value)
  end

  return paths
end

function _G.harpoon_make_finder(paths)
  return require("telescope.finders").new_table({ results = paths })
end

function _G.harpoon_open_telescope_marks()
  require("telescope").extensions.harpoon.marks()
end
