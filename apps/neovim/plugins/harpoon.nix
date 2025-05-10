{
  # TODO: enable deleting marks w/o confirmation
  plugins = {
    harpoon = {
      enable = true;

      enableTelescope = true;
      saveOnToggle = true;
      markBranch = true;

      keymaps = {
        "addFile" = "<leader>a";
        "toggleQuickMenu" = "<C-o>";
      };
    };
  };
}
