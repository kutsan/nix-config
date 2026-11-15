{
  flake.modules.homeManager.rumdl =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.rumdl ];

      xdg.configFile."rumdl/rumdl.toml".source = ./rumdl.toml;
    };
}
