{ styles, ... }: {
  services.jankyborders = {
    enable = true;
    hidpi = true;
    active_color = styles.hexColors.workspaceActive;
    inactive_color = styles.hexColors50.workspaceInactive;
  };
}
