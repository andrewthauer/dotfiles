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
if [ -d "${HOMEBREW_PREFIX}/opt/fzf" ]; then
  _FZF_DIR="${HOMEBREW_PREFIX}/opt/fzf"
elif [ -d "/usr/local/opt/fzf" ]; then
  _FZF_DIR="/usr/local/opt/fzf"
elif [ -d "${XDG_DATA_HOME}/fzf" ]; then
  _FZF_DIR="${XDG_DATA_HOME}/fzf"
else
  return 1
fi

# Shell directory
_SHELL_DIR="${_FZF_DIR}/shell"

# Current shell
if [ -n "${BASH_VERSION}" ]; then
  _SHELL_TYPE="bash"
elif [ -n "${ZSH_VERSION}" ]; then
  _SHELL_TYPE="zsh"
fi

# Completion & keybindings
if [ -d "$_SHELL_DIR" ]; then
  source_file "${_SHELL_DIR}/completion.${_SHELL_TYPE}"
  source_file "${_SHELL_DIR}/key-bindings.${_SHELL_TYPE}"
fi

# Default command
export FZF_DEFAULT_COMMAND="rg-files"
export FZF_DEFAULT_OPTS="--style full --inline-info --preview 'preview {} | head -n 500'"
# export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --inline-info --preview 'preview {} | head -n 500'"

# Ctrl-z Command (find files and directories)
# Keybindings
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
# export FZF_CTRL_T_OPTS=""

# Alt-C Command (find directories)
export FZF_ALT_C_COMMAND="rg-dirs"
# export FZF_CTRL_R_OPTS=""

# Keybindings for zsh
if [ "${_SHELL_TYPE}" = "zsh" ]; then
  bindkey -M emacs '^Y' fzf-cd-widget
  # bindkey -M vicmd '^Y' fzf-cd-widget
  # bindkey -M viins '^Y' fzf-cd-widget
fi

#
# Aliases
#

# shellcheck disable=SC2139
alias ff="${FZF_CTRL_T_COMMAND} | fzf"
# shellcheck disable=SC2139
alias ffd="${FZF_ALT_C_COMMAND} | fzf"
alias fzfm='fzf --multi'

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

# Cleanup
unset _FZF_DIR
unset _SHELL_DIR
unset _SHELL_TYPE
