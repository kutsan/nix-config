let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        bat
        btop
        fd
        fx
        fzf
        jq
        ripgrep
        tokei
        tree
        yazi
        zoxide
      ];
    };
in
{
  flake.modules.nixos.cli = sharedModule;
  flake.modules.darwin.cli = sharedModule;
}
