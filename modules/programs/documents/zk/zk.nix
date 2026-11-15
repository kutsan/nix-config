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
  flake.modules.nixos.zk = sharedModule;
  flake.modules.darwin.zk = sharedModule;
}
