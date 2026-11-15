{
  flake.modules.darwin.mole-cleaner =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        mole-cleaner
      ];
    };
}
