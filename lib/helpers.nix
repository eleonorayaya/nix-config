let
  filter_ls = path: ext: (
    builtins.map (name: path + "/${name}") (
      builtins.filter (name: builtins.match ".*\\.${ext}" name != null) (
        builtins.attrNames (builtins.readDir path)
      )
    )
  );

  concat_ls = path: ext: (
    builtins.concatStringsSep "\n" (
      builtins.map (filename: builtins.readFile filename) (
        filter_ls path ext
      )
    )
  );
in
{
  filter_ls = filter_ls;  
  concat_ls  = concat_ls;
}
