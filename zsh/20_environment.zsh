# ====== Basics ======

autoload -Uz run-help
autoload -Uz add-zsh-hook
autoload -Uz colors && colors
autoload -Uz compinit && compinit -u
autoload -Uz is-at-least

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# ====== Directory ======

setopt AUTO_CD

# ====== History ======

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY

# ====== Completion ======

setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END

# ====== Prompt ======

setopt PROMPT_SUBST

# ====== Completion ======

setopt AUTO_MENU
setopt MENU_COMPLETE

zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'

# ====== Terminal ======

# Keep directory when opening new tab
precmd() { print -Pn "\e]2; %~/ \a" }
preexec() { print -Pn "\e]2; %~/ \a" }
