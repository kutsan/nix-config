let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        act
        devcontainer
        dive
        lazydocker
      ];
    };
in
{
  flake.modules.nixos.containers = sharedModule;

  flake.modules.darwin.containers = {
    imports = [ sharedModule ];

    homebrew.casks = [
      "docker-desktop"
      "docker/tap/sbx"
    ];
  };
}
