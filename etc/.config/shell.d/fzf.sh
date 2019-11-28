#
# Fuzzy finder
#
# - https://github.com/junegunn/fzf
#

# The fzf install directory
if [[ -d "/usr/local/opt/fzf" ]]; then
  FZF_DIR="/usr/local/opt/fzf"
elif [[ -d "${XDG_DATA_HOME}/fzf" ]]; then
  FZF_DIR="${XDG_DATA_HOME}/fzf"
else
  return 1
fi

# Current shell
if [[ -n "${BASH_VERSION}" ]]; then
  SHELL_TYPE="bash"
elif [[ -n "${ZSH_VERSION}" ]]; then
  SHELL_TYPE="zsh"
fi

# Setup fzf
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}${FZF_DIR}/bin"
fi

# Auto-completion
[[ $- == *i* ]] && source "${FZF_DIR}/shell/completion.${SHELL_TYPE}" 2> /dev/null

# Key bindings
source "${FZF_DIR}/shell/key-bindings.${SHELL_TYPE}"

# Cleanup
unset FZF_DIR
unset SHELL_TYPE
