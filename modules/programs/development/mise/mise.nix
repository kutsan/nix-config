let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        mise
      ];
    };
in
{
  flake.modules.nixos.mise = sharedModule;
  flake.modules.darwin.mise = sharedModule;
}
