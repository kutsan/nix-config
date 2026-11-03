#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail
shopt -s inherit_errexit nullglob
IFS=$'\n\t'

find_nix_files() {
	git ls-files -z -- '*.nix'
}

main() {
	find_nix_files |
		xargs --null --no-run-if-empty nixfmt --check --
}

main "$@"
