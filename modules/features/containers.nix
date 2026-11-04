let
  packages =
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
  flake.modules.nixos.base = packages;

  flake.modules.darwin.base = {
    imports = [ packages ];

    homebrew.casks = [
      "docker-desktop"
      "docker/tap/sbx"
    ];
  };
}
