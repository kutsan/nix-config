{
  perSystem =
    { mkFormatterCheck, ... }:
    {
      checks.nix-format = mkFormatterCheck "nix";
    };
}
