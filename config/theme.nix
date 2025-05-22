{ pkgs
, self
, ...
}:
let
  helpers = import ../lib/helpers.nix { inherit pkgs; };

  mapColors = colorAttrs: opacity: (
    builtins.listToAttrs (map
      (
        key: {
          name = key;
          value = helpers.colorToHexWithOpacity colorAttrs."${key}" opacity;
        }
      )
      (builtins.attrNames colorAttrs))
  );

  themeConfigs = {
    catppuccin-frappe = {
      themeFile = "${self}/theme/catppuccin/frappe.json";

      fileMapper = themeContent: {
        inherit (themeContent) text;

        inherit (themeContent) overlay0;
        inherit (themeContent) overlay1;
        inherit (themeContent) overlay2;

        inherit (themeContent) surface0;
        inherit (themeContent) surface1;
        inherit (themeContent) surface2;

        textHighlight = themeContent.lavender;
        workspaceActive = themeContent.flamingo;
        workspaceInactive = themeContent.overlay0;
      };

      kitty = {
        url = "https://raw.githubusercontent.com/catppuccin/kitty/main/themes/frappe.conf";
        hash = "sha256-boYuT8Ptiy1598hptuKX88lKOIbixOAwCvGX6ln92iQ=";
      };
    };

    rose-pine-moon = {
      themeFile = "${self}/theme/rose-pine/moon.json";

      fileMapper = themeContent: {
        inherit (themeContent) text;

        # TODO
        overlay0 = themeContent.overlay;
        overlay1 = themeContent.overlay;
        overlay2 = themeContent.overlay;

        # TODO
        surface0 = themeContent.surface;
        surface1 = themeContent.surface;
        surface2 = themeContent.surface;

        textHighlight = themeContent.highlightMed;
        workspaceActive = themeContent.iris;
        workspaceInactive = themeContent.foam;
      };

      kitty = {
        url = "https://raw.githubusercontent.com/rose-pine/kitty/refs/heads/main/dist/rose-pine-moon.conf";
        hash = "sha256-ivIvhG2/duKfUXeJqcYfGnlKzpR5bxhV0+R3FT6AF64=";
      };
    };
  };

  themes = builtins.listToAttrs (
    builtins.map
      (themeName:
        let
          config = themeConfigs.${themeName};
          themeContent = builtins.fromJSON (builtins.readFile config.themeFile);

          themeColors = config.fileMapper themeContent;
          themeHexColors = mapColors themeColors "ff";
          themeHexColors75 = mapColors themeColors "BF";
          themeHexColors50 = mapColors themeColors "7F";
          themeHexColors25 = mapColors themeColors "40";
        in
        {
          name = themeName;
          value = {
            name = themeName;

            colors = themeColors;
            hexColors = themeHexColors;
            hexColors75 = themeHexColors75;
            hexColors50 = themeHexColors50;
            hexColors25 = themeHexColors25;
          };
        }
      )
      (builtins.attrNames themeConfigs));

  commonStyles = {
    # Status Bar
    statusBarHeight = 48;
    statusBarMarginBot = 32;
    screenMarginBot = 72;
    screenMarginTop = 32;
    screenMarginX = 72;

    # Windows
    windowMargin = 16;
  };

  selectedTheme = themes.rose-pine-moon;
  mergedTheme = commonStyles // selectedTheme;
in
mergedTheme
