{ pkgs, self, ... }: {
  fonts.packages = with pkgs; [
    dejavu_fonts
    font-awesome
    hack-font
    noto-fonts
    noto-fonts-emoji
  ];



  system = {
    stateVersion = 5;

    activationScripts.postUserActivation.text = ''
      /usr/local/bin/desktoppr ${self}/theme/wallpaper/cozy-autumn-rain.png

      # (Workaround) install mas manually
      # ${self}/scripts/manage-mas.sh
      
      # Run display mode optimization script
      # ${self}/scripts/display-mode.sh
      
      # Following line should allow us to avoid a logout/login cycle when changing settings
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      controlcenter = {
        BatteryShowPercentage = true;
        Bluetooth = true;
      };
      CustomUserPreferences = {
        # Easiest way to figure these values out is to set them manually
        # Then run `defaults read com.apple.symbolichotkeys AppleSymbolicHotKeys`
        "com.apple.symbolichotkeys" = {
          AppleSymbolicHotkeys = {
            # Sets 'copy selected screenshot area to clipboard' shortcut to cmd+ctrl+w
            "31" = {
              enabled = true;
              value = {
                parameters = [ 119 13 1310720 ];
                type = "standard";
              };
            };
          };
        };
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
