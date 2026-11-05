let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        delta
        gh
        git
        git-standup
        lazygit
      ];
    };
in
{
  flake.modules.nixos.git = sharedModule;
  flake.modules.darwin.git = sharedModule;
}
