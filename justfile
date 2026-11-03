set shell := ["bash", "-c"]
set default-list

[group('apply')]
apply:
    chezmoi apply

[group('check')]
[parallel]
check: check-shellcheck check-selene check-neovim-types check-zizmor check-pinact check-shfmt check-tombi check-actionlint check-nix check-just

[group('check')]
check-shellcheck:
    bash scripts/check/shellcheck.sh

[group('check')]
check-selene:
    bash scripts/check/selene.sh

[group('check')]
check-neovim-types:
    bash scripts/check/neovim-types.sh

[group('check')]
check-zizmor:
    zizmor --strict-collection .github/workflows/

[group('check')]
check-pinact:
    pinact run --check --verify

[group('check')]
check-shfmt:
    bash scripts/check/shfmt.sh

[group('check')]
check-tombi:
    tombi format --check

[group('check')]
check-actionlint:
    actionlint

[group('check')]
check-nix:
    bash scripts/check/nix.sh

[group('check')]
check-just:
    just --fmt --check

[group('format')]
[parallel]
format: format-shfmt format-tombi format-nix format-just

[group('format')]
format-shfmt:
    bash scripts/format/shfmt.sh

[group('format')]
format-tombi:
    tombi format

[group('format')]
format-nix:
    nix fmt

[group('format')]
format-just:
    just --fmt

[group('update')]
update-pinact:
    pinact run --update

[group('update')]
update-zsh-plugins:
    bash scripts/update/zsh-plugins.sh

[group('update')]
update-nix:
    nix flake update

[group('docs')]
docs-generate-keyboard-docs:
    node scripts/docs/generate-keyboard-docs.ts

[group('themes')]
themes-generate: && format
    bash scripts/themes/generate.sh
