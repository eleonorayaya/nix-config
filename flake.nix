{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    nix-formatter-pack = {
      # use by running `nix fmt`
      url = "github:Gerschtli/nix-formatter-pack";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0-1.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , homebrew-bundle
    , homebrew-cask
    , homebrew-core
    , home-manager
    , lix-module
    , mac-app-util
    , nix-darwin
    , nix-homebrew
    , nixpkgs
    , nix-formatter-pack
    ,...
    }:
    let
      host = {
        name = "mac-studio";
        computerName = "mac-studio";
        hostName = "mac-studio.local";
        localHostName = "mac-studio";
      };

      user = {
        name = "Eleonora Tennyson";
        username = "eleonora";
        githubUsername = "eleonorayaya";
        homeDirectory = "/Users/eleonora";
      };

      theme = { };

      configuration = { pkgs,  ... }: {
        networking = {
          inherit (host) hostName;
          inherit (host) localHostName;
          inherit (host) computerName;
        };

        users.users.${user.username} = {
          home = user.homeDirectory;
          shell = pkgs.zsh;
        };

        nix = {
          gc = {
            automatic = true;
            interval = { Hour = 5; Minute = 0; };
            options = "--delete-older-than 7d";
          };
          optimise = {
            automatic = true;
            interval = { Hour = 6; Minute = 0; };
          };
          settings = {
            experimental-features = ''
              flakes nix-command no-url-literals
            '';
          };
        };

        nixpkgs = {
          hostPlatform = "aarch64-darwin";
          config = {
            allowUnfree = true;
            allowBroken = false;
            allowInsecure = false;
            allowUnsupportedSystem = false;
          };
        };
      };
      forEachSystem = nixpkgs.lib.genAttrs [ "aarch64-darwin" ];
    in
    {
      formatter = forEachSystem (system:
        nix-formatter-pack.lib.mkFormatter {
          pkgs = nixpkgs.legacyPackages.${system};

          config.tools = {
            deadnix.enable = true;
            nixpkgs-fmt.enable = true;
            statix.enable = true;
          };
        });
      darwinConfigurations.${host.name} = nix-darwin.lib.darwinSystem {
        modules = [
          configuration

          # Pass variables to other modules
          {
            _module.args = {
              inherit user host self theme;
            };
          }

          ./config/default.nix

          home-manager.darwinModules.home-manager
          lix-module.nixosModules.default
          nix-homebrew.darwinModules.nix-homebrew
          mac-app-util.darwinModules.default

          {
            nix-homebrew = {
              enable = true;

              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = false;

              user = user.username;

              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
                "homebrew/homebrew-bundle" = homebrew-bundle;
              };

              mutableTaps = false;
              autoMigrate = true;
            };
          }
        ];
      };
    };
}
