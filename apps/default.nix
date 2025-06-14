{ pkgs
, ...
}:
let
  helpers = import ../lib/helpers.nix { inherit pkgs; };

  terminal_apps = helpers.filterLs ./terminal "nix";
in
{
  imports = [
    ./aerospace/aerospace.nix
    ./jankyborders/jankyborders.nix
    ./kitty/kitty.nix
    ./neovim/neovim.nix
    ./sketchybar/sketchybar.nix
  ] ++ terminal_apps;
}
