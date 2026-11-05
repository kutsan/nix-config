# shellcheck shell=bash

# Scripts can run from a shell without the usual setup, like the first
# `install.sh` run on a fresh machine.

if [[ $OSTYPE == darwin* ]]; then
	PATH="/opt/homebrew/bin:/run/current-system/sw/bin:${PATH}"
	export PATH
fi
