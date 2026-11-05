let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        nmap
        trippy
      ];
    };
in
{
  flake.modules.nixos.network = sharedModule;

  flake.modules.darwin.network = {
    imports = [ sharedModule ];

    homebrew.casks = [
      "proxyman"
    ];
  };
}
