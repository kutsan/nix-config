let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        gh
      ];
    };
in
{
  flake.modules.nixos.gh = sharedModule;
  flake.modules.darwin.gh = sharedModule;
}
