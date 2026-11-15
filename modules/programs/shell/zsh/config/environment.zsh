# man
export MANWIDTH='100'
if command -v nvim &>/dev/null; then
	export MANPAGER='nvim +Man!'
fi

# GnuPG
export GPG_TTY="$TTY"

# mise
if command -v mise &>/dev/null; then
	eval "$(mise activate zsh)"
fi
