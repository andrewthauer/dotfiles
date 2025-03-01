#
# XDG Base Directory Specification
#

# maven
# alias mvn="mvn -gs "$XDG_CONFIG_HOME"/maven/settings.xml"

# Subversion
# alias svn="svn --config-dir $"($env.XDG_CONFIG_HOME)/subversion"

# wget
# alias wget="wget --hsts-file=$"($env.XDG_CACHE_HOME)/wget-hsts"

#
# General
#

# directory listing
alias l="ls -a"
alias ll="ls -la"

# dotfiles
alias dotdir="cd $DOTFILES_DIR"

#
# Module specific
#

# deno
alias dt="deno task"

# git
alias g="git"
alias gcm="git checkout"
alias gb="git branch"
alias gco="git checkout"
alias gcm="git cm"
alias gs="git switch"
alias gst="git status"
alias gwt="git worktree"

# kubernetes
alias k="kubectl"

# lazygit
alias lg="lazygit"

# ruby
alias be="bundle exec"

# terraform
alias tf="terraform"

# vim / neovim
alias vi="nvim"
alias vim="nvim"
