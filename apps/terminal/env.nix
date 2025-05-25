{ user
, ...
}: {
  home-manager.users.${user.username} = _: {
    home.sessionVariables = {
      ICLOUD_DRIVE = "${user.homeDirectory}/Library/Mobile Documents/com~apple~CloudDocs";
    };
  };
}
