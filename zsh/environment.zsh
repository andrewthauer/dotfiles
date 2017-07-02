# ====== Smart URL's ======

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# ====== Basics ======

autoload -Uz run-help
autoload -Uz add-zsh-hook
autoload -Uz colors && colors
autoload -Uz is-at-least

# ====== Options ======

# Wait 10s for wildcard delete
setopt RM_STAR_WAIT

# Auto add variable-stored paths to ~ list.
unsetopt AUTO_NAME_DIRS

# ====== Completions ======

# Completion waiting dots
COMPLETION_WAITING_DOTS="true"

# ZSH highlighting
# ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
