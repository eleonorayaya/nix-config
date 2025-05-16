{ self
, pkgs
, globalStyles
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

  itemNames = pkgs.lib.traceVal (pkgs.lib.strings.concatLines (
    builtins.map (item: item.name) items
  ));

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

  hexTheme = builtins.listToAttrs (map
    (
      key: {
        name = key;
        value = "0xff${theme."${key}"}";
      }
    )
    (builtins.attrNames theme));

  colors = {
    BLACK = "0xff181926";
    WHITE = "0xffcad3f5";
    RED = "0xffed8796";
    GREEN = "0xffa6da95";
    BLUE = "0xff8aadf4";
    YELLOW = "0xffeed49f";
    ORANGE = "0xfff5a97f";
    MAGENTA = "0xffc6a0f6";
    GREY = "0xff939ab7";
    DARK_GREY = "0xcc24273a";
    TRANSPARENT = "0x00000000";
    SPOTIFY_GREEN = "0xff1db954";
  };
  
  sfMono = "Liga SFMono Nerd Font";
  sfPro = "SF Pro Display";

  styles = {
    FONT=sfPro;
    POPUP_BORDER_WIDTH = 2;
    POPUP_CORNER_RADIUS = 11;

    ICON_COLOR = colors.WHITE;
    ICON_FONT=sfMono;
    ICON_HIGHLIGHT_COLOR = colors.MAGENTA;
    LABEL_COLOR = colors.WHITE;
    LABEL_HIGHLIGHT_COLOR = colors.MAGENTA;

    POPUP_BACKGROUND_COLOR = colors.BLACK;
    POPUP_BORDER_COLOR = colors.GREEN;

    SHADOW_COLOR = colors.BLACK;
    ACTIVE_WORKSPACE_COLOR = colors.WHITE;
    EMPTY_WORKSPACE_COLOR = colors.GREY;

    BAR_COLOR = hexTheme.surface0;
    BAR_CORNER_RADIUS = 9;
    BAR_HEIGHT = globalStyles.statusBarHeight;
    BAR_MARGIN = globalStyles.screenMarginX;
    BAR_PADDING_X = 16;
    BAR_TOP_OFFSET = globalStyles.screenMarginTop;

    SPACES_WRAPPER_BACKGROUND = hexTheme.surface1;
    SPACES_ITEM_BACKGROUND = hexTheme.surface2;
  };

  icons = import ./icons.nix;
  barIcons = {
    HERO_ICON=icons.GHOST;
    HOME_ICON=icons.HOME;
    BROWSER_ICON=icons.IE;
    DISCORD_ICON=icons.DISCORD;
    OBSIDIAN_ICON=icons.NOTES_2;
    MAIL_ICON=icons.MAIL_2;
    TERMINAL_ICON=icons.TERMINAL_2;
    PREFERENCES_ICON=icons.PREFERENCES;
    ACTIVITY_ICON=icons.BOMB;
    LOCK_ICON=icons.LOCK;
  };

    envVars = pkgs.lib.traceVal (
      helpers.attrs_to_env_vars (
        colors // styles // barIcons
      )
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
