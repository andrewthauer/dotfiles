#
# Common Aliases
#

alias dotdir="cd ${DOTFILES_DIR}"

#
# Directories
#

# Listing
alias l="ls -1A"         # Lists in one column, hidden files.
alias ll="ls -lh"        # Lists human readable sizes.
alias lr="ll -R"         # Lists human readable sizes, recursively.
alias la="ll -a"         # Lists human readable sizes, hidden files.
alias lm="la | $PAGER"   # Lists human readable sizes, hidden files through pager.
alias lx="ll -XB"        # Lists sorted by extension (GNU only).
alias lk="ll -Sr"        # Lists sorted by size, largest last.
alias lt="ll -tr"        # Lists sorted by date, most recent last.
alias lc="lt -c"         # Lists sorted by date, most recent last, shows change time.
alias lu="lt -u"         # Lists sorted by date, most recent last, shows access time.

# Directory stack
alias d="dirs -v"

# Find from relative pwd
alias findhere="find . -name"

#
# Resource Usage
#

alias df="df -kh"
alias du="du -kh"

if [[ "$OSTYPE" == darwin* || "$OSTYPE" == *bsd* ]]; then
  alias topc="top -o cpu"
  alias topm="top -o vsize"
else
  alias topc="top -o %CPU"
  alias topm="top -o %MEM"
fi

# Displays process with grep
function psg() { ps aux | { head -1; grep -v grep | grep -i "$1"; } }

# Displays user owned processes status.
function psu {
  ps -U "${1:-$LOGNAME}" -o "pid,%cpu,%mem,command" "${(@)argv[2,-1]}"
}

#
# Networking
#

# list all tcp ports
alias lstcp="lsof -i -n -P | grep TCP"

#
# Clipboard
#

# Mac OS X Everywhere
if [[ "$OSTYPE" == darwin* ]]; then
  alias o="open"
elif [[ "$OSTYPE" == cygwin* ]]; then
  alias o="cygstart"
  alias pbcopy="tee > /dev/clipboard"
  alias pbpaste="cat /dev/clipboard"
else
  alias o="xdg-open"

  if [[ -x "$(command -v xclip)" ]]; then
    alias pbcopy="xclip -selection clipboard -in"
    alias pbpaste="xclip -selection clipboard -out"
  elif [[ -x "$(command -v xsel)" ]]; then
    alias pbcopy="xsel --clipboard --input"
    alias pbpaste="xsel --clipboard --output"
  fi
fi

alias pbc="pbcopy"
alias pbp="pbpaste"

#
# File Download
#

if [[ -x "$(command -v curl)" ]]; then
  alias get="curl --continue-at - --location --progress-bar --remote-name --remote-time"
elif [[ -x "$(command -v wget)" ]]; then
  alias get="wget --continue --progress=bar --timestamping"
fi

#
# Archives
#

# untar a file
untar() {
  "tar -xf $1 -C $2"
}

#
# Git
#

alias g="git"
alias ga="git add"
alias gaa="git add --all"
alias gb="git branch"
alias gba="git branch -a"
alias gbd="git branch -d"
alias gci="git commit"
alias gcb="git checkout -b"
alias gcf="git config --list"
alias gcm="git checkout master"
alias gcim="git commit -m"
alias gcisb="git cisb"
alias gco="git checkout"
alias gd="git diff"
alias gpushu="git pushu"
alias gpushf="git pushf"
alias grm="git rebase -i master"
alias grc="git rebase --continue"
alias gsb="git squashbase"
alias gst="git status"
alias gwt="git worktree"

#
# Docker
#

if [[ ! -x "$(command -v docker)" ]]; then
  alias dk='docker'

  # Images
  alias di='docker images'
  # alias dbu='docker build'
  alias drmi='docker rmi'
  alias drmi_all='docker rmi $* $(docker images -a -q)'
  alias drmi_dang='docker rmi $* $(docker images -q -f dangling=true)'

  # Containers
  alias dps='docker ps'
  alias dpsa='docker ps -a'
  alias dpsc='docker ps -a --format="table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.RunningFor}}\t{{.Status}}"'
  alias dpsl='docker ps -l $*'
  alias dstart='docker start $*'
  alias dstop='docker stop $*'
  alias dstop_all='docker stop $* $(docker ps -q -f status=running)'
  alias drestart='docker restart $*'
  alias dattach='docker attach $*'
  alias dexec='docker exec'
  alias drun='docker run --rm $*'
  alias drunit='docker run --rm -it $*'
  alias dinspect='docker inspect $*'
  alias dlog='docker logs'
  alias dip='docker inspect --format="{{.NetworkSettings.IPAddress}}" $*'
  alias drm='docker rm'
  alias drm_stopped='docker rm $* $(docker ps -q -f status=exited)'
  alias drm_all='docker rm $* $(docker ps -a -q)'
  alias drmv_stopped='docker rm -v $* $(docker ps -q -f status=exited)'
  alias drmv_all='docker rm -v $* $(docker ps -a -q)'

  # Volumes
  alias dvls='docker volume ls $*'
  alias dvrm='docker volume rm $*'
  alias dvrm_all='docker volume rm $(docker volume ls -q)'
  alias dvrm_dang='docker volume rm $(docker volume ls -q -f dangling=true)'

  # docker-compose
  alias dco='docker-compose'
  alias dcb='docker-compose build'
  alias dce='docker-compose exec'
  alias dceit='docker-compose exec -it'
  alias dcps='docker-compose ps'
  alias dcr='docker-compose run --rm'
  alias dcrs='docker-compose run --rm --service-ports'
  alias dcrm='docker-compose rm'
  alias dcstart='docker-compose start'
  alias dcstop='docker-compose stop'
  alias dcrestart='docker-compose restart'
  alias dcup='docker-compose up'
  alias dcupd='docker-compose up -d'
  alias dcdn='docker-compose down'
  alias dcl='docker-compose logs'
  alias dclf='docker-compose logs -f'
  alias dctail='docker-compose logs --tail=all -f'
fi

#
# Node
#

# node & npm
if [[ -x "$(command -v node)" ]]; then
  # npm list
  alias npm-list="npm list --depth=0 2>/dev/null"
  alias npm-list-g="npm list -g --depth=0 2>/dev/null"

  # npm outdated
  alias npm-outdated="npm outdated --depth 0 -q"
  alias npm-outdated-g="npm outdated -g --depth 0 -q"
fi

# nodenv
if [[ -x "$(command -v nodenv)" ]]; then
  alias nenv="nodenv"
  alias nenv-a="nodenv alias"
  alias nenv-dpi="nodenv default-packages install --all"
fi

#
# Ruby
#

if [[ -x "$(command -v ruby)" ]]; then
  alias be="bundle exec"
fi

#
# Homebrew
#

# Skip if homebrew is not installed
if [[ -x "$(command -v brew)" ]]; then
  # Homebrew
  alias brewc="brew cleanup"
  alias brewi="brew install"
  alias brewu="brew uninstall"
  alias brewl="brew list"
  alias brewo="brew outdated"
  alias brewr="brew remove"
  alias brews="brew search"
  alias brewupg="brew update && brew upgrade"
  alias brewuses="brew uses --installed"

  # Homebrew Bundle
  alias brewb="brew bundle --global"
  alias brewbh="brewb --help"
  alias brewbi="brewb install"
  alias brewbl="brewb list"

  # Homebrew Cask
  alias cask="brew cask"
  alias caskc="brew cask cleanup --outdated"
  alias caskC="brew cask cleanup"
  alias caski="brew cask install"
  alias caskl="brew cask list"
  alias casko="brew cask outdated"
  alias casks="brew cask search"
  alias caskx="brew cask uninstall"

  # Composite aliases
  alias brew-upgrade="brew update && brew upgrade"
  alias brew-clean="brew cleanup && brew cask cleanup"
fi

#
# Miscellaneous
#

# Serves a directory via HTTP
if [[ -x $(command -v python3) ]]; then
  alias http-serve="python3 -m http.server"
else
  alias http-serve="python -m SimpleHTTPServer"
fi
