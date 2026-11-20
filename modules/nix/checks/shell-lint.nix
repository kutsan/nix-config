{
  perSystem =
    { pkgs, mkSandboxCheck, ... }:
    {
      checks.shell-lint = mkSandboxCheck "shell-lint" {
        tools = [ pkgs.shellcheck ];
        script = ''
          find . -type f \( -name '*.sh' -o -name '*.zsh' \) -print0 |
            xargs --null --no-run-if-empty shellcheck --
        '';
      };
    };
}
