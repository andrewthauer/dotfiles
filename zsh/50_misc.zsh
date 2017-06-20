# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Completion
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

# ====== Terminal ======

# Keep directory when opening new tab
precmd() { print -Pn "\e]2; %~/ \a" }
preexec() { print -Pn "\e]2; %~/ \a" }
