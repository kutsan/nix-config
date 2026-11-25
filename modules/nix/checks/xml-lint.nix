{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      checks.xml-lint = pkgs.runCommand "check-xml-lint" { nativeBuildInputs = [ pkgs.libxml2 ]; } ''
        cd ${inputs.self}
        find . -type f -name '*.xml' -print0 |
          xargs --null --no-run-if-empty xmllint --noout
        touch "$out"
      '';
    };
}
