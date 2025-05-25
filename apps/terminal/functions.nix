{ user
, ...
}:
let
  helperPath = ".zsh/helpers";

  funcFiles = builtins.attrNames (builtins.readDir ./functions);

  functionDefs = builtins.map
    (file:
      {
        name = "${helperPath}/${file}";
        value = {
          executable = true;
          source = ./functions/${file};
        };
      }
    )
    funcFiles;

  functionConfig = builtins.listToAttrs functionDefs;

  indexFileContent = builtins.concatStringsSep "\n" (
    builtins.map
      (file:
        ". ~/${helperPath}/${file}"
      )
      funcFiles
  );

  fileConfig = {
    "${helperPath}/index.zsh" = {
      text = indexFileContent;
    };
  } // functionConfig;
in
{
  home-manager.users.${user.username} = _: {
    home.file = fileConfig;
  };
}
