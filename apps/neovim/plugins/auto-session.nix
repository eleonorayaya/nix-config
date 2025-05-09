{
  plugins = {
    auto-session = {
      enable = true;

      settings = {
        enabled = true;
        use_git_branch = true;
        auto_create = true;
        auto_save = true;
        auto_restore = true;

        post_restore_cmds.__raw = ''
          {
            function()
              local nvim_tree_api = require("nvim-tree.api")

              nvim_tree_api.tree.change_root(vim.fn.getcwd())
              nvim_tree_api.tree.reload()
              nvim_tree_api.tree.open()
            end,
          }
        '';
      };
    };
  };
}
