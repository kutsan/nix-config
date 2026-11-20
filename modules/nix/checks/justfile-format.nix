{
  perSystem =
    { mkFormatterCheck, ... }:
    {
      checks.justfile-format = mkFormatterCheck "justfile";
    };
}
