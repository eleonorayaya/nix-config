
_: 
let
  helpers = import ../lib/helpers.nix;

  terminal_apps = helpers.filter_ls ./terminal "nix";
in
{
  imports = [
    ./aerospace/aerospace.nix
    ./kitty/kitty.nix
    ./neovim/neovim.nix
    ./sketchybar/sketchybar.nix
  ] ++ terminal_apps;
}
