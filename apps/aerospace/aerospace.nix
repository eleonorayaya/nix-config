{ pkgs
, styles
, ...
}:
let
  sb = "${pkgs.sketchybar}/bin/sketchybar";
  trigger-workspace-change = "${sb} --trigger aerospace_workspace_change";
  trigger-workspace-monitor-change = "${sb} --trigger aerospace_workspace_monitor_change";

  bindings = {
    alt-q = [ "mode main" "workspace 1" ];
    alt-w = [ "mode main" "workspace 2" ];
    alt-e = [ "mode main" "workspace 3" ];
    alt-r = [ "mode main" "workspace 4" ];
    alt-u = [ "mode main" "workspace 5" ];
    alt-i = [ "mode main" "workspace 6" ];
    alt-o = [ "mode main" "workspace 7" ];
    alt-p = [ "mode main" "workspace 8" ];

    alt-tab = "workspace-back-and-forth";
    alt-shift-tab = [
      "move-workspace-to-monitor --wrap-around next"
      "exec-and-forget ${trigger-workspace-monitor-change}"
    ];

    alt-shift-semicolon = "mode service";
  };
in
{
  services.aerospace = {
    enable = true;
    settings = {
      gaps = {
        inner.horizontal = styles.windowMargin;
        inner.vertical = styles.windowMargin;
        outer.left = styles.screenMarginX;
        outer.bottom = styles.screenMarginBot;
        outer.top = styles.screenMarginTop + styles.statusBarHeight + styles.statusBarMarginBot;
        outer.right = styles.screenMarginX;
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
        # Browser
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
        "${trigger-workspace-change} FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE"
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
          run = [ "move-node-to-workspace 2 --focus-follows-window" ];
        }
        {
          # Zoom
          "if".app-id = "us.zoom.xos";
          run = [ "layout floating" "move-node-to-workspace 1" ];
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
          "if".during-aerospace-startup = true;
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
