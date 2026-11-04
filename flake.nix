{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/3";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli/nix-homebrew";
    };
    homebrew-docker = {
      url = "github:docker/homebrew-tap";
      flake = false;
    };
    homebrew-jackielii = {
      url = "github:jackielii/homebrew-tap";
      flake = false;
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { config, ... }:
      {
        imports = [
          inputs.flake-parts.flakeModules.modules
          ./modules/flake/dev-shells.nix
          ./modules/flake/formatter.nix
          ./modules/system/homebrew.nix
          ./modules/features/3d.nix
          ./modules/features/ai.nix
          ./modules/features/app-store.nix
          ./modules/features/backup.nix
          ./modules/features/browsers.nix
          ./modules/features/cli.nix
          ./modules/features/cloud.nix
          ./modules/features/communication.nix
          ./modules/features/containers.nix
          ./modules/features/databases.nix
          ./modules/features/design.nix
          ./modules/features/dev-tools.nix
          ./modules/features/disks.nix
          ./modules/features/downloads.nix
          ./modules/features/editors.nix
          ./modules/features/encryption.nix
          ./modules/features/finance.nix
          ./modules/features/git.nix
          ./modules/features/keyboard.nix
          ./modules/features/media.nix
          ./modules/features/network.nix
          ./modules/features/notes.nix
          ./modules/features/reading.nix
          ./modules/features/terminal.nix
          ./modules/features/utilities.nix
          ./modules/features/window-management.nix
        ];

        systems = [
          "aarch64-darwin"
          "aarch64-linux"
          "x86_64-linux"
        ];

        flake = {
          darwinConfigurations = {
            personal = inputs.nix-darwin.lib.darwinSystem {
              modules = [
                inputs.determinate.darwinModules.default
                config.flake.modules.darwin.base
                {
                  determinateNix.enable = true;
                  nixpkgs.hostPlatform = "aarch64-darwin";
                  system = {
                    stateVersion = 7;
                    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
                    primaryUser = "kutsan";
                  };
                  programs.direnv.enable = true;
                }
              ];
            };
          };

          nixosConfigurations = {
            nixos = inputs.nixpkgs.lib.nixosSystem {
              modules = [
                config.flake.modules.nixos.base
                {
                  nixpkgs.hostPlatform = "x86_64-linux";
                  system = {
                    stateVersion = "26.11";
                    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
                  };

                  networking.hostName = "nixos";

                  nix.settings.experimental-features = [
                    "nix-command"
                    "flakes"
                  ];

                  programs.direnv.enable = true;

                  boot.loader.systemd-boot.enable = true;
                  fileSystems."/" = {
                    device = "/dev/disk/by-label/nixos";
                    fsType = "ext4";
                  };
                }
              ];
            };
          };
        };
      }
    );
}
