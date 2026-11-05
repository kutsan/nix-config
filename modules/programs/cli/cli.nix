let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        bat
        btop
        fd
        fx
        jq
        ripgrep
        tokei
        tree
        yazi
      ];
    };
in
{
  flake.modules.nixos.cli = sharedModule;
  flake.modules.darwin.cli = sharedModule;
}
