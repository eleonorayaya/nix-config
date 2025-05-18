{ pkgs, ... }:
let
  filterLs = path: ext: (
    builtins.map (name: path + "/${name}") (
      builtins.filter (name: builtins.match ".*\\.${ext}" name != null) (
        builtins.attrNames (builtins.readDir path)
      )
    )
  );

  concatLs = path: ext: (
    builtins.concatStringsSep "\n" (
      builtins.map (filename: builtins.readFile filename) (
        filterLs path ext
      )
    )
  );

  attrsToEnvVars = attrs: (
    pkgs.lib.strings.concatLines (
      map
        (key:
          let
            val = attrs."${key}";
            strVal = builtins.toString val;
          in
          ''export ${key}="${strVal }"''
        )
        (builtins.attrNames attrs)
    )
  );

  colorToHexWithOpacity = color: opacity: "0x${opacity}${color}";
  colorToHex = color: (colorToHexWithOpacity color "ff");
in
{
  inherit attrsToEnvVars;
  inherit colorToHex;
  inherit colorToHexWithOpacity;
  inherit concatLs;
  inherit filterLs;
}
