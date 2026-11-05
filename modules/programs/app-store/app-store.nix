{
  flake.modules.darwin.app-store =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        mas
      ];
    };
}
