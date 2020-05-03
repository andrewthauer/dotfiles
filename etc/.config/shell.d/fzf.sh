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
export FZF_DEFAULT_LAYOUT_OPTS="--layout=reverse --inline-info"
export FZF_DEFAULT_PREVIEW_OPT="--preview 'catx {} | head -n 500'"

# Default options
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_LAYOUT_OPTS} ${FZF_DEFAULT_PREVIEW_OPT}"

# Use ripgrep
export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden --follow --glob '!.git/*'"

# Keybindings
# export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
# export FZF_ALT_C_COMMAND=""
# export FZF_CTRL_T_OPTS=""
# export FZF_CTRL_R_OPTS=""

# Aliases
alias fzfi='rg --files --no-ignore --hidden --follow --glob "!.git/*" | fzf'
alias vifi='vim $(fzfi)'
alias kp='fzf-kill-process'
alias ks='fzf-kill-server'

#
# Completions
#

# Make dirname consistent
# - dirname on OS X behaves funky, get gdirname via (brew install coreutils)
export dirname_command="dirname"
[[ $(uname) == "Darwin" ]] && dirname_command="gdirname"

# Use ~~ as the trigger sequence instead of the default **
# export FZF_COMPLETION_TRIGGER='~~'

# Options to fzf command
export FZF_COMPLETION_OPTS='+c -x'

# Command for listing path candidates
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  # fd --hidden --follow --exclude ".git" . "$1"
  rg --hidden --follow --glob "!.git/*" "$1"
}

# Faster compgen
_fzf_compgen_dir() {
  # fd --type d --hidden --follow --exclude ".git" . "$1"
  rg --files --null --hidden --glob "!.git/*" "$1" 2 >/dev/null |
    xargs -0 "$dirname_command" |
    awk '!h[$0]++'
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
