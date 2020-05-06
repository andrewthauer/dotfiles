#
# Initialize fasd
#
# - https://github.com/clvv/fasd
#

# shellcheck disable=SC1090

# Ensure fasd is installed
if ! command_exists "fasd"; then
  return 1
fi

# Data directory
[ ! -d "${XDG_DATA_HOME}/fasd" ] && mkdir -p "${XDG_DATA_HOME}/fasd"
[ ! -d "${XDG_CACHE_HOME}/fasd" ] && mkdir -p "${XDG_CACHE_HOME}/fasd"

# The data location
export _FASD_DATA="${XDG_DATA_HOME}/fasd/data"

# Initialize fasd for bash
if [ -n "${BASH_VERSION}" ]; then
  fasd_cache="${XDG_CACHE_HOME}/fasd/init-cache-bash"
  if [ "$(command -v fasd)" -nt "$fasd_cache" ] || [ ! -s "$fasd_cache" ]; then
    export _FASD_DATA="$_FASD_DATA"
    fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >|"$fasd_cache"
    unset _FASD_DATA
  fi
  source "$fasd_cache"
  unset fasd_cache

# Initialize fasd for zsh
elif [ -n "${ZSH_VERSION}" ]; then
  fasd_cache="${XDG_CACHE_HOME}/fasd/init-cache-zsh"
  if [ "$(command -v fasd)" -nt "$fasd_cache" ] || [ ! -s "$fasd_cache" ]; then
    fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install >|"$fasd_cache"
  fi
  source "$fasd_cache"
  unset fasd_cache

# Use auto initialize
else
  eval "$(fasd --init auto)"
fi

#
# Aliases
#

alias a='fasd -a'             # Any
alias s='fasd -si'            # Show/search/select
alias sd='fasd -sid'          # Interactive directory selection
alias sf='fasd -sif'          # Interactive file selection
alias d='fasd -d'             # Directory
alias f='fasd -f'             # File
alias v='f -e vim -b viminfo' # Vim
alias z='fasd_cd -d'          # cd - same functionality as j in autojump
alias zz='fasd_cd -d -i'      # Interactive cd
