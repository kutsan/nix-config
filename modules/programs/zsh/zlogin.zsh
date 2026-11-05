# shellcheck disable=SC1070,SC2168

# Asynchronously zcompile `.zcompdump` file.
{
	# This file is created in `compinit.zsh`.
	local zcompdump_path="$XDG_CACHE_HOME/zsh/zcompdump"

	if [[ -s "$zcompdump_path" && (! -s "${zcompdump_path}.zwc" || "$zcompdump_path" -nt "${zcompdump_path}.zwc") ]]; then
		zcompile "$zcompdump_path"
	fi
} &|
