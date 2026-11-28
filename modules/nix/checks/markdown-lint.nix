{ inputs, ... }:
{
  perSystem =
    { lib, pkgs, ... }:
    let
      rumdl = pkgs.rumdl.overrideAttrs (previousAttrs: {
        buildInputs =
          previousAttrs.buildInputs or [ ]
          ++ lib.optional (
            pkgs.stdenv.hostPlatform.isLinux && pkgs.stdenv.hostPlatform.isAarch64
          ) pkgs.rust-jemalloc-sys;
      });
    in
    {
      checks.markdown-lint = pkgs.runCommand "check-markdown-lint" { nativeBuildInputs = [ rumdl ]; } ''
        cd ${inputs.self}
        rumdl check --no-cache .
        touch "$out"
      '';
    };
}
