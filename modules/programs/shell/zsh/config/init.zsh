typeset -ga configs=(
	modules
	options
	completion
	line-editor
)

for name in "${configs[@]}"; do
	# shellcheck disable=SC1090
	source "${0%/*}/$name.zsh"
done

unset configs name
