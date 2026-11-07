let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        btop
        fd
        fx
        jq
        ripgrep
        tokei
        tree
      ];
    };
in
{
  flake.modules.nixos.cli = sharedModule;
  flake.modules.darwin.cli = sharedModule;
}
