#
# Customized environment settings
#

#
# Basics
#

autoload -Uz run-help
autoload -Uz add-zsh-hook
autoload -Uz is-at-least

#
# Smart URL's
#

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

#
# Options
#

# Wait 10s for wildcard delete
# setopt RM_STAR_WAIT

#
# Prompt
#

# Auto add variable-stored paths to ~ list.
unsetopt AUTO_NAME_DIRS

# Disable auto correct
unsetopt CORRECT_ALL
unsetopt CORRECT
DISABLE_CORRECTION="true"

# ZSH syntax highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)

#
# Completions
#

# Completion waiting dots
COMPLETION_WAITING_DOTS="true"
