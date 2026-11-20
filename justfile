set shell := ["bash", "-c"]
set default-list

[group('check')]
check:
    nix flake check --keep-going

[group('check')]
[parallel]
check-online: check-workflow-pins-online check-workflow-security-online

[group('check')]
check-workflow-pins-online:
    nix run .#workflow-pins-online

[group('check')]
check-workflow-security-online:
    nix run .#workflow-security-online

[group('format')]
format:
    nix fmt

[group('update')]
update-flake:
    nix flake update

[group('update')]
update-workflow-pins:
    nix run .#workflow-pins-update

[group('themes')]
themes-generate: && format
    bash scripts/themes/generate.sh
