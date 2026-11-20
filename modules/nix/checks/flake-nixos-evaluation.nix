{ inputs, ... }:
{
  perSystem =
    { lib, mkEvaluationCheck, ... }:
    {
      checks.flake-nixos-evaluation = mkEvaluationCheck "flake-nixos-evaluation" (
        lib.mapAttrs (_: host: host.config.system.build.toplevel.drvPath) inputs.self.nixosConfigurations
      );
    };
}
