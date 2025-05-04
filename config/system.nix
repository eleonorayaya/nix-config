
{ pkgs, self, ... }: {
  fonts.packages = with pkgs; [
  ];

  networking = {
    dns = [
    ];
    knownNetworkServices = [
      "Thunderbolt Bridge"
      "Wi-Fi"
    ];
  };

  power = {
    sleep = {
      computer = 30;
      display = 10;
    };
  };

  security.pam.enableSudoTouchIdAuth = true;

  system = {
    stateVersion = 5;

    activationScripts.postUserActivation.text = ''
    '';

    # Set Git commit hash for darwin-version.
    configurationRevision = self.rev or self.dirtyRev or null;

    defaults = {
      controlcenter = {
        BatteryShowPercentage = true;
        Bluetooth = true;
      };
      CustomUserPreferences = {
        # # Easiest way to figure these values out is to set them manually
        # # Then run `defaults read com.apple.symbolichotkeys AppleSymbolicHotKeys`
        # "com.apple.symbolichotkeys" = {
        #   AppleSymbolicHotkeys = {
        #     # Sets 'copy selected screenshot area to clipboard' shortcut to cmd+ctrl+w
        #     "31" = {
        #       enabled = true;
        #       value = {
        #         parameters = [ 119 13 1310720 ];
        #         type = "standard";
        #       };
        #     };
        #   };
        # };
      };
      dock = {
        autohide = true;
        launchanim = true;
        mru-spaces = false;
        orientation = "bottom";
        persistent-others = [ ];
        show-recents = false;
        tilesize = 64;
      };
      finder = {
        _FXShowPosixPathInTitle = true;
        CreateDesktop = false;
        FXEnableExtensionChangeWarning = false;
        FXDefaultSearchScope = "SCcf"; # Search current folder by default
        QuitMenuItem = true;
      };
      LaunchServices.LSQuarantine = false;
      NSGlobalDomain = {
        # Finder
        NSNavPanelExpandedStateForSaveMode = true;
        NSNavPanelExpandedStateForSaveMode2 = true;
        NSTableViewDefaultSizeMode = 1; # Small

        # UI
        AppleInterfaceStyle = "Dark";
        _HIHideMenuBar = true;

        # Mouse
        ApplePressAndHoldEnabled = false;

        # System
        AppleShowAllExtensions = false;
        AppleShowAllFiles = true;
        NSDisableAutomaticTermination = false;

        # Sound
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;

        # Spellcheck
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
      };
      screencapture = {
        disable-shadow = true;
        show-thumbnail = false;
        target = "clipboard";
        type = "png";
      };
      trackpad = {
        Clicking = false;
        TrackpadThreeFingerDrag = false;
      };
    };
  };
}
