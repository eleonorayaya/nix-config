{ ... }: {
  imports = [
    ./aerospace/aerospace.nix
    ./kitty/kitty.nix
  ] ++ (builtins.map (name: ./terminal + "/${name}")
    (builtins.filter (name: builtins.match ".*\\.nix" name != null)
      (builtins.attrNames (builtins.readDir ./terminal))));
}
