{ pkgs
, self
, ...
}:
let
  theme = builtins.fromJSON (builtins.readFile "${self}/theme/catppuccin/frappe.json");

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

  colors = {
    inherit (theme) text;

    inherit (theme) overlay0;
    inherit (theme) overlay1;
    inherit (theme) overlay2;

    inherit (theme) surface0;
    inherit (theme) surface1;
    inherit (theme) surface2;

    textHighlight = theme.lavender;
    workspaceActive = theme.flamingo;
    workspaceInactive = theme.overlay0;
  };

  hexColors = mapColors colors "ff";
  hexColors50 = mapColors colors "88";
  hexColors25 = mapColors colors "44";

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

  inherit colors;
  inherit hexColors;
  inherit hexColors50;
  inherit hexColors25;
} 
