# Completion settings
zstyle ':completion:*' menu no                    # Disable the completion menu in favor of `fzf-tab` plugin.
zstyle ':completion:*:descriptions' format '[%d]' # Show descriptions in brackets.
zstyle ':completion:*' rehash true                # When new programs is installed, auto update without reloading.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# shellcheck disable=SC2086,SC2296
zstyle ':completion:*' list-colors ${(s#:#)LS_COLORS} # Match dircolors with completion schema.
