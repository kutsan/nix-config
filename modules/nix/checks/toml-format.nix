{ inputs, ... }:
{
  perSystem =
    { config, ... }:
    {
      checks.toml-format = (config.formatter.check inputs.self).overrideAttrs (previousAttrs: {
        name = "check-toml-format";
        env = previousAttrs.env // {
          TREEFMT_FORMATTERS = "toml";
        };
      });
    };
}
