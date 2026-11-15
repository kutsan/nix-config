let
  sharedModule =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        git-standup
      ];
    };
in
{
  flake.modules.nixos.git-standup = sharedModule;
  flake.modules.darwin.git-standup = sharedModule;
}
