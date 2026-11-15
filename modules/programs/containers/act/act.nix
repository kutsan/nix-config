let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        act
      ];
    };
in
{
  flake.modules.nixos.act = sharedModule;
  flake.modules.darwin.act = sharedModule;
}
