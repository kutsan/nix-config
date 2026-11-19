{ inputs, ... }:
{
  flake.modules.nixos.personal-laptop = {
    imports = with inputs.self.modules.nixos; [
      system-desktop
      personal
    ];

    system.stateVersion = "26.11";

    boot.loader.systemd-boot.enable = true;
    fileSystems."/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };
  };
}
