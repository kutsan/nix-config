{ inputs, ... }:
{
  perSystem =
    { lib, pkgs, ... }:
    {
      checks.flake-darwin-evaluation = builtins.deepSeq (lib.mapAttrs (
        _: host: host.config.system.build.toplevel.drvPath
      ) inputs.self.darwinConfigurations) pkgs.emptyFile;
    };
}
