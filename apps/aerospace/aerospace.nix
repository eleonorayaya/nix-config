{ pkgs
, theme
, ...
}:
let
  sb = "${pkgs.sketchybar}/bin/sketchybar";
  triggerWorkspaceChange = "${sb} --trigger aerospace_workspace_change";
  triggerWorkspaceMonitorChange = "${sb} --trigger aerospace_workspace_monitor_change";

  bindings = {
    alt-q = [ "mode main" "workspace 1" ];
    alt-w = [ "mode main" "workspace 2" ];
    alt-e = [ "mode main" "workspace 3" ];
    alt-r = [ "mode main" "workspace 4" ];
    alt-u = [ "mode main" "workspace 5" ];
    alt-i = [ "mode main" "workspace 6" ];
    alt-o = [ "mode main" "workspace 7" ];
    alt-p = [ "mode main" "workspace 8" ];

    alt-shift-q = "move-node-to-workspace 1 --focus-follows-window";
    alt-shift-w = "move-node-to-workspace 2 --focus-follows-window";
    alt-shift-e = "move-node-to-workspace 3 --focus-follows-window";
    alt-shift-r = "move-node-to-workspace 4 --focus-follows-window";
    alt-shift-u = "move-node-to-workspace 5 --focus-follows-window";
    alt-shift-i = "move-node-to-workspace 6 --focus-follows-window";
    alt-shift-o = "move-node-to-workspace 7 --focus-follows-window";
    alt-shift-p = "move-node-to-workspace 8 --focus-follows-window";

    alt-tab = "workspace-back-and-forth";
    alt-shift-tab = [
      "move-workspace-to-monitor --wrap-around next"
      "exec-and-forget ${triggerWorkspaceMonitorChange}"
    ];

    alt-shift-semicolon = "mode service";
  };
in
{
  services.aerospace = {
    enable = true;
    settings = {
      gaps = {
        inner.horizontal = theme.windowMargin;
        inner.vertical = theme.windowMargin;
        outer.left = theme.screenMarginX;
        outer.bottom = theme.screenMarginBot;
        outer.top = theme.screenMarginTop + theme.statusBarHeight + theme.statusBarMarginBot;
        outer.right = theme.screenMarginX;
      };

      mode.main.binding = {
        alt-space = [ "mode term" "workspace T" ];
      } // bindings;

      mode.term.binding = {
        alt-space = [ "mode main" "workspace-back-and-forth" ];
      } // bindings;

      workspace-to-monitor-force-assignment = {
        "T" = "main";

        # Home
        "1" = "main";

        "2" = "main";

        # Unused
        "4" = "main";

        # Notes
        "5" = [
          "secondary"
          "main"
        ];

        # Unused
        "6" = [
          "secondary"
          "main"
        ];

        # Unused
        "7" = [
          "secondary"
          "main"
        ];

        # Mail
        "8" = [
          "secondary"
          "main"
        ];
      };

      exec-on-workspace-change = [
        "/bin/bash"
        "-c"
        "${triggerWorkspaceChange} FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE"
      ];

      automatically-unhide-macos-hidden-apps = true;

      mode.service.binding = {
        esc = [ "reload-config" "mode main" ];
        r = [ "flatten-workspace-tree" "mode main" ];
        f = [ "layout floating tiling" "mode main" ];
        backspace = [ "close-all-windows-but-current" "mode main" ];
      };

      on-window-detected = [
        {
          # Kitty
          "if".app-id = "net.kovidgoyal.kitty";
          run = [ "move-node-to-workspace T --focus-follows-window" ];
        }
        {
          # Arc
          "if".app-id = "company.thebrowser.Browser";
          "if".during-aerospace-startup = true;
          run = [ "move-node-to-workspace 2 --focus-follows-window" ];
        }
        {
          # Zoom
          "if".app-id = "us.zoom.xos";
          run = [ "layout floating" "move-node-to-workspace 1" ];
        }

        {
          # TickTick
          "if".app-id = "com.TickTick.task.mac";
          run = [ "move-node-to-workspace 7 --focus-follows-window" ];
        }
        {
          # Finder
          "if".app-id = "com.apple.finder";
          run = [ "layout floating" "move-node-to-workspace 1" ];
        }
        {
          # Proton Mail
          "if".app-id = "ch.protonmail.desktop";
          run = [ "move-node-to-workspace 8" ];
        }
        {
          # Discord
          "if".app-id = "com.hnc.Discord";
          run = [ "move-node-to-workspace 3" ];
        }
        {
          # Slack
          "if".app-id = "com.tinyspeck.slackmacgap";
          run = [ "move-node-to-workspace 6" ];
        }
        {
          # Obsidian
          "if".app-id = "md.obsidian";
          run = [ "move-node-to-workspace 5" ];
        }
      ];

      on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];

      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;

      accordion-padding = 50;
    };
  };
}
