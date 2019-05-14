#
# ZSH Prompt
#
# These files need to be symlinked
#  - pure.zsh -> 'prompt_pure_setup'
#  - async.zsh -> async
#

# Initialize prompt
autoload -U promptinit
promptinit

# Load the pure prompt
prompt pure
