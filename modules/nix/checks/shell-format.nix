{ inputs, ... }:
{
  perSystem =
    { config, ... }:
    {
      checks.shell-format = (config.formatter.check inputs.self).overrideAttrs (previousAttrs: {
        name = "check-shell-format";
        env = previousAttrs.env // {
          TREEFMT_FORMATTERS = "shell";
        };
      });
    };
}
