{ ... }: {
  imports = [
    ./home.nix
    ./tmp-system.nix
    # ./homebrew.nix
    # ./packages.nix
    # ./system.nix
    ../apps
  ];
}
