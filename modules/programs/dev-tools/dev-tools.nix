let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        mise
        nodejs_26
      ];
    };
in
{
  flake.modules.nixos.dev-tools = sharedModule;
  flake.modules.darwin.dev-tools = sharedModule;
}
