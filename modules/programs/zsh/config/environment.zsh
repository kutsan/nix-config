# man
export MANWIDTH='100'
if command -v nvim &>/dev/null; then
	export MANPAGER='nvim +Man!'
fi

# GnuPG
export GPG_TTY="$TTY"

if command -v mise &>/dev/null; then
	eval "$(mise activate zsh)"
fi

# ls
LS_COLORS="$(<"$XDG_CONFIG_HOME/ls/colors")"
export LS_COLORS
