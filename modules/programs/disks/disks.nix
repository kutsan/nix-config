let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        gptfdisk
      ];
    };
in
{
  flake.modules.nixos.disks = sharedModule;

  flake.modules.darwin.disks =
    { pkgs, ... }:
    {
      imports = [ sharedModule ];

      environment.systemPackages = with pkgs; [
        mole-cleaner
      ];

      homebrew.casks = [
        "neodisk"
        "pearcleaner"
      ];
    };
}
