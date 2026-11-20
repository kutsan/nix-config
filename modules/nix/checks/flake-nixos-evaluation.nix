{ inputs, ... }:
{
  perSystem =
    { lib, pkgs, ... }:
    {
      checks.flake-nixos-evaluation = builtins.deepSeq (lib.mapAttrs (
        _: host: host.config.system.build.toplevel.drvPath
      ) inputs.self.nixosConfigurations) pkgs.emptyFile;
    };
}
