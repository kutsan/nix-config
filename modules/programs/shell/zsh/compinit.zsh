# Cache directory should be created manually since zsh doesn't create
# XDG Base Directory paths automatically.
typeset -g zsh_cache_dir="$XDG_CACHE_HOME/zsh"

if [[ ! -d "$zsh_cache_dir" ]]; then
	command mkdir -p -- "$zsh_cache_dir"
fi

# Initialize the completion system with a cache time of 24 hours.
# `-C` skips security check & cache validation when zcompdump is < 24h old.
typeset -g zcompdump_path="${zsh_cache_dir}/zcompdump"

# The `(#q)` glob below needs `EXTENDED_GLOB`, and this file runs before `options.zsh`.
setopt EXTENDED_GLOB
autoload -Uz compinit

# shellcheck disable=SC1009,SC1036,SC1072,SC1073
if [[ -n $zcompdump_path(#qNm-24) ]]; then
	compinit -i -C -d "$zcompdump_path"
else
	compinit -i -d "$zcompdump_path"
fi

unset zsh_cache_dir zcompdump_path
