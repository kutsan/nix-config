{
  perSystem =
    { mkFormatterCheck, ... }:
    {
      checks.toml-format = mkFormatterCheck "toml";
    };
}
