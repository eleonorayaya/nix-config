{ theme, ... }: {
  services.jankyborders = {
    enable = true;
    hidpi = true;
    active_color = theme.hexColors.workspaceActive;
    inactive_color = theme.hexColors50.workspaceInactive;
  };
}
