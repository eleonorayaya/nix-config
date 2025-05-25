{ self
, pkgs
, theme
, ...
}:
let
  helpers = import ../../lib/helpers.nix { inherit pkgs; };

  plugins = builtins.map
    (filename: pkgs.writeShellApplication rec {
      name = "plugin_${builtins. elemAt (pkgs.lib.strings.splitString "." filename) 0}";
      text = builtins.readFile "${self}/apps/sketchybar/plugins/${filename}";
      derivationArgs.buildInputs = with pkgs; [
        aerospace
        sketchybar
      ];

      runtimeInputs = derivationArgs.buildInputs;
    })
    (
      builtins.attrNames (builtins.readDir ./plugins)
    );

  items = builtins.map
    (filename: pkgs.writeShellApplication rec {
      name = "item_${builtins. elemAt (pkgs.lib.strings.splitString "." filename) 0}";
      text = builtins.readFile "${self}/apps/sketchybar/items/${filename}";
      derivationArgs.buildInputs = with pkgs; [
        aerospace
        sketchybar
      ] ++ plugins;

      runtimeInputs = derivationArgs.buildInputs;
    })
    (
      builtins.attrNames (builtins.readDir ./items)
    );

  itemNames = pkgs.lib.strings.concatLines (
    builtins.map (item: item.name) items
  );

  rc = pkgs.writeShellApplication rec {
    name = "sketchybarrc";
    text = builtins.readFile ./sketchybarrc.sh;
    derivationArgs.buildInputs =
      (with pkgs; [
        aerospace
        sketchybar
        gnugrep
      ]) ++ plugins ++ items;

    runtimeInputs = derivationArgs.buildInputs;
  };

  sfMono = "Liga SFMono Nerd Font";
  sfPro = "SF Pro Display";

  barStyles = {
    FONT = sfPro;
    POPUP_BORDER_WIDTH = 2;
    POPUP_CORNER_RADIUS = 11;

    ICON_COLOR = theme.hexColors.text;
    ICON_FONT = sfMono;
    ICON_HIGHLIGHT_COLOR = theme.hexColors.textHighlight;
    LABEL_COLOR = theme.hexColors.text;
    LABEL_HIGHLIGHT_COLOR = theme.hexColors.textHighlight;

    POPUP_BACKGROUND_COLOR = theme.hexColors.overlay0;
    POPUP_BORDER_COLOR = theme.hexColors.overlay1;

    SHADOW_COLOR = theme.hexColors.surface2;
    ACTIVE_WORKSPACE_COLOR = theme.hexColors.workspaceActive;

    BAR_COLOR = theme.hexColors75.surface0;
    BAR_CORNER_RADIUS = 9;
    BAR_HEIGHT = theme.statusBarHeight;
    BAR_MARGIN = theme.screenMarginX;
    BAR_PADDING_X = 16;
    BAR_TOP_OFFSET = theme.screenMarginTop;

    SPACES_WRAPPER_BACKGROUND = theme.hexColors.surface1;
    SPACES_ITEM_BACKGROUND = theme.hexColors.surface2;
  };

  icons = import ./icons.nix;
  barIcons = {
    HERO_ICON = icons.GHOST;
    HOME_ICON = icons.HOME;
    BROWSER_ICON = icons.IE;
    DISCORD_ICON = icons.DISCORD;
    OBSIDIAN_ICON = icons.NOTES_2;
    MAIL_ICON = icons.MAIL_2;
    TASKS_ICON = icons.CHECKLIST;
    TERMINAL_ICON = icons.TERMINAL_2;
    PREFERENCES_ICON = icons.PREFERENCES;
    ACTIVITY_ICON = icons.BOMB;
    LOCK_ICON = icons.LOCK;
  };

  envVars = helpers.attrsToEnvVars (
    barStyles // barIcons
  );
in
{
  config = {
    services.sketchybar = {
      enable = true;
      config = ''
        ${envVars}
        sketchybarrc
        ${itemNames}
      '';
      extraPackages = [
        pkgs.gnugrep
        rc
      ] ++ plugins ++ items;
    };
  };
}
