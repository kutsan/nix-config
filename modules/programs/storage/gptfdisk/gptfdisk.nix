let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        gptfdisk
      ];
    };
in
{
  flake.modules.nixos.gptfdisk = sharedModule;
  flake.modules.darwin.gptfdisk = sharedModule;
}
