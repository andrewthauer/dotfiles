#
# Fuzzy finder (fzf)
#
# - https://github.com/junegunn/fzf
#

# shellcheck disable=SC1090

# Skip if not using fzf (default is fzf)
FUZZY_FINDER="${FUZZY_FINDER:-fzf}"
[ "${FUZZY_FINDER}" != "fzf" ] && return 1

# The install directory
if [[ -d "${PROFILE_PREFIX}/opt/fzf" ]]; then
  FZF_DIR="${PROFILE_PREFIX}/opt/fzf"
elif [[ -d "/usr/local/opt/fzf" ]]; then
  FZF_DIR="/usr/local/opt/fzf"
elif [[ -d "${XDG_DATA_HOME}/fzf" ]]; then
  FZF_DIR="${XDG_DATA_HOME}/fzf"
else
  return 1
fi

# Shell directory
SHELL_DIR="${FZF_DIR}/shell"

# Current shell
if [[ -n "${BASH_VERSION}" ]]; then
  SHELL_TYPE="bash"
elif [[ -n "${ZSH_VERSION}" ]]; then
  SHELL_TYPE="zsh"
fi

# Setup path
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}${FZF_DIR}/bin"
fi

# Completion & keybindings
if [ -d "$SHELL_DIR" ]; then
  source "${SHELL_DIR}/completion.${SHELL_TYPE}"
  source "${SHELL_DIR}/key-bindings.${SHELL_TYPE}"
fi

# Cleanup
unset FZF_DIR
unset SHELL_DIR
unset SHELL_TYPE

# Default options
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --inline-info --preview 'preview {} | head -n 500'"

# Use ripgrep
export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden --follow --no-messages"

# Keybindings
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_ALT_C_COMMAND="rg-dirs"
# export FZF_CTRL_T_OPTS=""
# export FZF_CTRL_R_OPTS=""

# Aliases
alias fzfm='fzf -m'
# shellcheck disable=SC2139
alias fzff="${FZF_DEFAULT_COMMAND} | fzf"
alias fzfvi='nvim $(fzfi)'

#
# Completions
#

# Use ~~ as the trigger sequence instead of the default **
# export FZF_COMPLETION_TRIGGER='~~'
export FZF_COMPLETION_TRIGGER='**'

# Completion options for fzf command
# export FZF_COMPLETION_OPTS=''

# Command for listing path candidates
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  rg-files "${1:-.}"
}

# Faster compgen
_fzf_compgen_dir() {
  rg-dirs "${1:-.}"
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
