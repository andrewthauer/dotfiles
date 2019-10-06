#
# ZSH Prompt
#

# Disable auto correct
unsetopt CORRECT
unsetopt CORRECT_ALL
DISABLE_CORRECTION=true

# Initialize prompt
autoload -U promptinit
promptinit

# Load the pure prompt
# NOTE: The async & prompt_pure_setup need to be in the fpath
#       before promptinit is calls
prompt "${ZSH_PROMPT}"
