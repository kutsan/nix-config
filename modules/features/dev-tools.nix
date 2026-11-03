let
  packages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        mise
        nodejs_26
      ];
    };
in
{
  flake.modules.nixos.base = packages;
  flake.modules.darwin.base = packages;
}
