function _G.telescope_pick_project_files()
  local opts = {}

  if is_git_repo() then
    opts = {
      cwd = get_git_root(),
    }
  end

  require("telescope.builtin").find_files(opts)
end

function _G.telescope_live_grep()
  require("telescope").extensions.live_grep_args.live_grep_args()
end
