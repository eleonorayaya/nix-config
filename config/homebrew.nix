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
      "rustup"
      "go-task"
    ];
    casks = [
      # Security
      "protonvpn"
      "proton-pass"
      "sf-symbols"

      # System Configuration
      "desktoppr"
    ];
  };
}
