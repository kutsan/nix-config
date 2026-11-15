let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        jq
      ];
    };
in
{
  flake.modules.nixos.jq = sharedModule;
  flake.modules.darwin.jq = sharedModule;
}
