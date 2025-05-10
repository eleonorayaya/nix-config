{ pkgs
, theme
, uiconfig
, ...
}:
let
  aerospacePlugin = pkgs.writeShellApplication rec {
    name = "aerospace_plugin";
    text = builtins.readFile ./plugins/aerospace.sh;
    derivationArgs.buildInputs = with pkgs; [
      aerospace
      sketchybar
    ];

    runtimeInputs = derivationArgs.buildInputs;
  };

  appNamePlugin = pkgs.writeShellApplication {
    name = "app_name_plugin";
    text = builtins.readFile ./plugins/app_name.sh;
    derivationArgs.buildInputs = [ pkgs.sketchybar ];
  };

  clockPlugin = pkgs.writeShellApplication rec {
    name = "clock_plugin";
    text = builtins.readFile ./plugins/clock.sh;
    derivationArgs.buildInputs = with pkgs; [
      aerospace
      sketchybar
    ];

    runtimeInputs = derivationArgs.buildInputs;
  };

  rc = pkgs.writeShellApplication rec {
    name = "sketchybarrc";
    text = builtins.readFile ./sketchybarrc.sh;
    derivationArgs.buildInputs =
      (with pkgs; [
        aerospace
        sketchybar
        gnugrep
      ])
      ++ [
        aerospacePlugin
        appNamePlugin
        clockPlugin
      ];

    runtimeInputs = derivationArgs.buildInputs;
  };
in
{
  config = {
    services.sketchybar = {
      enable = true;
      config = ''
        export THEME_BASE="${theme.base}"
        export THEME_TEXT="${theme.text}"
        export THEME_PINK="${theme.pink}"
        export THEME_SURFACE1="${theme.surface1}"
        export BAR_HEIGHT=${builtins.toString uiconfig.statusBarHeight}
        sketchybarrc
      '';
      extraPackages = [
        aerospacePlugin
        appNamePlugin
        clockPlugin
        pkgs.gnugrep
        rc
      ];
    };
  };
}
