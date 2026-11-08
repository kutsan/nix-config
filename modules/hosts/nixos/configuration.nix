{ inputs, ... }:
{
  flake.modules.nixos.nixos = {
    imports = with inputs.self.modules.nixos; [
      system-default

      kutsan

      cli
      cloud
      containers
      dev-tools
      direnv
      disks
      encryption
      git
      media
      neovim
      network
      notes
      zsh
    ];

    system.stateVersion = "26.11";

    networking.hostName = "nixos";

    boot.loader.systemd-boot.enable = true;
    fileSystems."/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };
  };
}
