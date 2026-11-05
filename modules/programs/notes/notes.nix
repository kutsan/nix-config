let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        zk
      ];
    };
in
{
  flake.modules.nixos.notes = sharedModule;
  flake.modules.darwin.notes = sharedModule;
}
