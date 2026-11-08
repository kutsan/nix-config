#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail
shopt -s inherit_errexit nullglob
IFS=$'\n\t'

find_shell_files() {
	git ls-files -z -- '*.sh' '*.zsh'
}

main() {
	find_shell_files |
		xargs --null --no-run-if-empty shellcheck --color=always --
}

main "$@"
