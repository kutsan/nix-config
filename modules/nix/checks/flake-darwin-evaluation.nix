{ inputs, ... }:
{
  perSystem =
    { lib, mkEvaluationCheck, ... }:
    {
      checks.flake-darwin-evaluation = mkEvaluationCheck "flake-darwin-evaluation" (
        lib.mapAttrs (_: host: host.config.system.build.toplevel.drvPath) inputs.self.darwinConfigurations
      );
    };
}
