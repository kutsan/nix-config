let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        nmap
      ];
    };
in
{
  flake.modules.nixos.nmap = sharedModule;
  flake.modules.darwin.nmap = sharedModule;
}
