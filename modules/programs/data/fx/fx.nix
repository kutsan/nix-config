let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        fx
      ];
    };
in
{
  flake.modules.nixos.fx = sharedModule;
  flake.modules.darwin.fx = sharedModule;
}
