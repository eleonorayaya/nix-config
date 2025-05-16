{ user, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    users.${user.username} = { lib, ... }: {
      home.username = user.username;
      home.homeDirectory = user.homeDirectory;

      programs.home-manager.enable = true;

      home.activation = {
        fetch-email =
          let
            emailScriptPath = ../scripts/fetch-email.sh;
          in
          lib.hm.dag.entryAfter [ "writeBoundary" ] ''
            # Set environment variables for the email fetch script
            export USER_NAME="${user.name}"
            export GITHUB_USERNAME="${user.githubUsername}"
          
            # Execute the scripts
            bash ${emailScriptPath}
          '';
      };

      # This value determines the Home Manager release that your
      # configuration is compatible with. This helps avoid breakage
      # when a new Home Manager release introduces backwards
      # incompatible changes.
      home.stateVersion = "24.11";

      # Aerospace makes mission control unusable unless apps are grouped
      targets.darwin.defaults."com.apple.dock".expose-group-apps = true;
    };
  };
}
