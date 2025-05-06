{ pkgs, ... }:
let
  sb = "${pkgs.sketchybar}/bin/sketchybar";
  trigger-workspace-change = "${sb} --trigger aerospace_workspace_change";
in
{
  services.aerospace = {
    enable = true;
    settings = {
      gaps = {
        inner.horizontal = 6;
        inner.vertical = 6;
        outer.left = 6;
        outer.bottom = 6;
        outer.top = 6;
        outer.right = 6;
      };

      mode.main.binding = {
        alt-space = [ "mode term" "workspace T" ];

        alt-q = "workspace 1";
        alt-w = "workspace 2";
        alt-e = "workspace 3";
        alt-r = "workspace 4";
        alt-u = "workspace 5";
        alt-i = "workspace 6";
        alt-o = "workspace 7";
        alt-p = "workspace 8";

        alt-tab = "workspace-back-and-forth";
        alt-shift-tab = "move-workspace-to-monitor --wrap-around next";

        alt-shift-semicolon = "mode service";
      };

      mode.term.binding = {
        alt-space = [ "mode main" "workspace-back-and-forth" ];

        alt-q = [ "mode main" "workspace 1" ];
        alt-w = [ "mode main" "workspace 2" ];
        alt-e = [ "mode main" "workspace 3" ];
        alt-r = [ "mode main" "workspace 4" ];
        alt-u = [ "mode main" "workspace 5" ];
        alt-i = [ "mode main" "workspace 6" ];
        alt-o = [ "mode main" "workspace 7" ];
        alt-p = [ "mode main" "workspace 8" ];

        alt-tab = "workspace-back-and-forth";
        alt-shift-tab = "move-workspace-to-monitor --wrap-around next";
      };

      workspace-to-monitor-force-assignment = {
        "T" = "main";

        "1" = "main";
        "2" = "main";
        "3" = "main";
        "4" = "main";

        "5" = [
          "secondary"
          "main"
        ];
        "6" = [
          "secondary"
          "main"
        ];
        "7" = [
          "secondary"
          "main"
        ];
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
