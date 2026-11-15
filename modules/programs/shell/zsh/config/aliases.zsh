# shellcheck disable=SC2139

# Editors
alias e="$EDITOR"
compdef e="$EDITOR"
alias ge="$GUI_EDITOR"
compdef ge="$GUI_EDITOR"

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

# Encryption
alias age-encrypt='age --encrypt --recipients-file "$XDG_CONFIG_HOME/age/recipients.txt"'
alias age-decrypt='age --decrypt --identity "$XDG_DATA_HOME/age/key.txt"'

# Package Managers
alias pn='pnpm'

# Git
alias g='git'
compdef g='git'

# shellcheck disable=SC2190
typeset -A git_aliases=(
	a add
	b branch
	bl branch
	c commit
	d diff
	ds diff
	f fetch
	l log
	ld log
	la log
	lda log
	r reflog
	rd reflog
	s status
	sm submodule
	sw switch
	t stash
	tl stash
)

# shellcheck disable=SC2066,SC2296
for key in "${(@k)git_aliases}"; do
	alias "g$key=git $key"
	compdef _git "g$key=git-${git_aliases[$key]}"
done

unset git_aliases key

# Disabled Commands
alias clear='echo "Use \`^L\`." >&2; false'
alias caffeinate='echo "Use equivalent GUI utility app." >&2; false'
