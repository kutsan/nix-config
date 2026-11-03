let
  packages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        gptfdisk
      ];
    };
in
{
  flake.modules.nixos.base = packages;

  flake.modules.darwin.base =
    { pkgs, ... }:
    {
      imports = [ packages ];

      environment.systemPackages = with pkgs; [
        mole-cleaner
      ];
    };
}
