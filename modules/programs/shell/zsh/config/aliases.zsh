# shellcheck disable=SC2139

# Editors
alias e="$EDITOR"
alias ge="$GUI_EDITOR"

# File & Directory Operations
alias mv='mv -iv'
alias mkdir='mkdir -p'

if command -v trash &>/dev/null; then
	alias rm='trash'
fi

# Create a temporary directory and `cd` into it.
scratch() {
	local dir
	dir=$(mktemp -d "${TMPDIR:-/tmp}/scratch.${1:+$1.}XXXXXX") || return
	builtin cd -- "$dir" && pwd
}

# Listing & Search
alias ls='ls -AF --color=auto'
[[ $OSTYPE == darwin* ]] && alias ls='ls -AFG'
alias la='ls -lAh'
alias grep="grep --color='auto'"

# Disk Usage
alias du='du -d 1 --si'
alias df='df -a --si'

# Utilities
if [[ $OSTYPE == darwin* ]]; then
	uuidgen() {
		case ${1-} in
		-7 | --time-v7)
			python3 -c 'import uuid; print(uuid.uuid7())'
			;;
		*)
			command uuidgen "$@" | tr '[:upper:]' '[:lower:]'
			;;
		esac
	}
fi

alias uuidv4='printf %s "$(uuidgen)"'
alias uuidv7='printf %s "$(uuidgen --time-v7)"'

# Package Managers
alias pn='pnpm'

# Disabled Commands
alias clear='echo "Use \`^L\`." >&2; false'
