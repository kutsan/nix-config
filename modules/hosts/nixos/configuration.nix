{ inputs, ... }:
{
  flake.modules.nixos.nixos = {
    imports = with inputs.self.modules.nixos; [
      system-cli
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
