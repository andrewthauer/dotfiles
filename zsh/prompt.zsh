#
# ZSH Prompt
#

# Add pure prompt to the fpath for 'sindresorhus/pure'
# NOTE: These files need to be symlinked
#  - pure.zsh -> 'prompt_pure_setup'
#  - async.zsh -> async
fpath=("${DOTFILES_REPOS_DIR}/zfunctions" $fpath)

# Initialize prompt
autoload -U promptinit
promptinit

# Load the pure prompt
prompt pure
