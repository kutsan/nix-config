#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail
IFS=$'\n\t'

readonly NVIM_CONFIG_DIR="modules/programs/editors/neovim/config"

main() {
	VIMRUNTIME="${NEOVIM_RUNTIME:?run inside the dev shell}" \
		lua-language-server --check "$NVIM_CONFIG_DIR"
}

main "$@"
