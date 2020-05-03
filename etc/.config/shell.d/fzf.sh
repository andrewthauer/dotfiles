#
# Fuzzy finder
#
# - https://github.com/junegunn/fzf
#

# shellcheck disable=SC2148,SC1090

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
[[ $- == *i* ]] && source "${FZF_DIR}/shell/completion.${SHELL_TYPE}" 2>/dev/null

# Key bindings
source "${FZF_DIR}/shell/key-bindings.${SHELL_TYPE}"

# Cleanup
unset FZF_DIR
unset SHELL_TYPE

# Custom variables
export FZF_DEFAULT_LAYOUT_OPTS='--height 40% --layout=reverse --inline-info'
export FZF_DEFAULT_PREVIEW_OPT="--preview 'catx {} | head -n 500'"

# Default options
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_LAYOUT_OPTS} ${FZF_DEFAULT_PREVIEW_OPT}"

# Use ripgrep
export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden --follow"

# Keybindings
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_ALT_C_COMMAND='rg-dir'
# export FZF_CTRL_T_OPTS=""
# export FZF_CTRL_R_OPTS=""

# Aliases
# shellcheck disable=SC2139
alias fzfi="${FZF_DEFAULT_COMMAND} | fzf"
alias vifi='vim $(fzfi)'
alias kp='fzf-kill-process'
alias ks='fzf-kill-server'

#
# Completions
#

# Use ~~ as the trigger sequence instead of the default **
# export FZF_COMPLETION_TRIGGER='~~'
export FZF_COMPLETION_TRIGGER='**'

# Options to fzf command
export FZF_COMPLETION_OPTS='+c -x'

# Command for listing path candidates
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  rg --files --hidden --follow "$1" 2>/dev/null
}

# Faster compgen
_fzf_compgen_dir() {
  rg-dir "${1:-.}"
}

# (EXPERIMENTAL) Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd) fzf "$@" --preview 'tree -C {} | head -200' ;;
    export | unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    ssh) fzf "$@" --preview 'dig {}' ;;
    *) fzf "$@" ;;
  esac
}
