{
  perSystem =
    { mkFormatterCheck, ... }:
    {
      checks.shell-format = mkFormatterCheck "shell";
    };
}
