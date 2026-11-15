{
  flake.modules.darwin.mas =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        mas
      ];
    };
}
