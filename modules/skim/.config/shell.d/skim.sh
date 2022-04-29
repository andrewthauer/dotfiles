#
# Fuzzy finder (skim)
#
# - https://github.com/lotabout/skim
#

# shellcheck disable=SC1090

# Skip if not using skim
[ "${FUZZY_FINDER}" != "sk" ] && return 1

# The install directory
if [[ -d "${PROFILE_PREFIX}/opt/sk" ]]; then
  SKIM_DIR="${PROFILE_PREFIX}/opt/sk"
elif [[ -d "/usr/local/opt/sk" ]]; then
  SKIM_DIR="/usr/local/opt/sk"
elif [[ -d "${XDG_DATA_HOME}/sk" ]]; then
  SKIM_DIR="${XDG_DATA_HOME}/sk"
else
  return 1
fi

# Current shell
if [[ -n "${BASH_VERSION}" ]]; then
  SHELL_TYPE="bash"
elif [[ -n "${ZSH_VERSION}" ]]; then
  SHELL_TYPE="zsh"
  SHELL_DIR="${SKIM_DIR}/share/zsh/site-functions"
fi

# Setup path
if [[ ! "$PATH" == */usr/local/opt/sk/bin* ]]; then
  export PATH="${PATH:+${PATH}:}${SKIM_DIR}/bin"
fi

# Completion & keybindings
if [ -d "$SHELL_DIR" ]; then
  source "${SHELL_DIR}/completion.${SHELL_TYPE}"
  source "${SHELL_DIR}/key-bindings.${SHELL_TYPE}"
fi

# Cleanup
unset SKIM_DIR
unset SHELL_DIR
unset SHELL_TYPE

# Default options
export SKIM_DEFAULT_OPTIONS="--preview 'preview {} | head -n 500'"

# Use ripgrep
export SKIM_DEFAULT_COMMAND="rg --files --no-ignore --hidden --follow --no-messages"

# Keybindings
export SKIM_CTRL_T_COMMAND="${SKIM_DEFAULT_COMMAND}"
export SKIM_ALT_C_COMMAND="rg-dirs"
# export SKIM_CTRL_T_OPTS=""
# export SKIM_CTRL_R_OPTS=""

# Aliases
alias skm='sk -m'
# shellcheck disable=SC2139
alias skf="${SKIM_DEFAULT_COMMAND} | sk"
alias skvi='nvim $(skfi)'

#
# Completions
#

# Use ~~ as the trigger sequence instead of the default **
# export SKIM_COMPLETION_TRIGGER='~~'
export SKIM_COMPLETION_TRIGGER='**'

# Completion options to skim command
# export SKIM_COMPLETION_OPTS=''

# Command for listing path candidates
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_sk_compgen_path() {
  rg-files "${1:-.}"
}

# Faster compgen
_sk_compgen_dir() {
  rg-dirs "${1:-.}"
}

# (EXPERIMENTAL) Advanced customization of skim options via _sk_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to skim.
_sk_comprun() {
  local command=$1
  shift

  case "$command" in
    cd) sk "$@" --preview 'tree -C {} | head -200' ;;
    export | unset) sk "$@" --preview "eval 'echo \$'{}" ;;
    ssh) sk "$@" --preview 'dig {}' ;;
    *) sk "$@" ;;
  esac
}
