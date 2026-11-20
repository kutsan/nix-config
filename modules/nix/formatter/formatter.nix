{
  perSystem =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      options.formatters = lib.mkOption {
        type = lib.types.attrsOf lib.types.raw;
        default = { };
      };

      config.formatter = pkgs.treefmt.withConfig {
        runtimeInputs = [ pkgs.git ];
        settings = {
          tree-root-file = "flake.nix";
          walk = "git";
          on-unmatched = "info";
          formatter = config.formatters;
        };
      };
    };
}
