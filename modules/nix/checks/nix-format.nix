{ inputs, ... }:
{
  perSystem =
    { config, ... }:
    {
      checks.nix-format = (config.formatter.check inputs.self).overrideAttrs (previousAttrs: {
        name = "check-nix-format";
        env = previousAttrs.env // {
          TREEFMT_FORMATTERS = "nix";
        };
      });
    };
}
