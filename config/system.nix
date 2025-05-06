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
  };
}
