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

  buildTheme = themeFile: colorMapFunc:
    let
      themeContent = builtins.fromJSON (builtins.readFile "${self}/theme/${themeFile}");

      themeColors = colorMapFunc themeContent;
      themeHexColors = mapColors themeColors "ff";
      themeHexColors50 = mapColors themeColors "88";
      themeHexColors25 = mapColors themeColors "44";
    in
    {
      colors = themeColors;
      hexColors = themeHexColors;
      hexColors50 = themeHexColors50;
      hexColors25 = themeHexColors25;
    };

  catppuccinFrappe = buildTheme "catppuccin/frappe.json" (themeContent: {
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
  });

  selectedTheme = catppuccinFrappe;
in
{
  # Status Bar
  statusBarHeight = 48;
  statusBarMarginBot = 32;
  screenMarginBot = 72;
  screenMarginTop = 32;
  screenMarginX = 72;

  # Windows
  windowMargin = 16;

  inherit (selectedTheme) colors;
  inherit (selectedTheme) hexColors;
  inherit (selectedTheme) hexColors50;
  inherit (selectedTheme) hexColors25;
} 
