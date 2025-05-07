_: {
  homebrew = {
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    enable = true;
    taps = [
      "homebrew/core"
      "homebrew/cask"
    ];
    brews = [
      # "neovim"
      "rustup"
    ];
    casks = [
      # Security
      "protonvpn"

      # System Configuration
      "desktoppr"
    ];
  };
}
