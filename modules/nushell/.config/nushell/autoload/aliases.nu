#
# Aliases for Nushell
#
# TODO: Modularize these aliases
#

#
# XDG path fixes
#

# maven
export alias mvn = mvn -gs $"($env.XDG_CONFIG_HOME)/maven/settings.xml"

# Subversion
export alias svn = svn --config-dir $"($env.XDG_CONFIG_HOME)/subversion"

# wgeg
export alias wget = wget --hsts-file=$"($env.XDG_CACHE_HOME)/wget-hsts"

#
# General aliases
#

# directory listing
export alias l = ls -a
export alias ll = ls -la
export alias ex = explore

# dotfiles
export alias dotdir = cd $env.DOTFILES_HOME

#
# Module aliases
#

# deno
export alias dt = deno task --quiet

# git
export alias g = git
export alias gcm = git checkout
export alias gb = git branch
export alias gco = git checkout
export alias gcm = git cm
export alias gs = git switch
export alias gst = git status
export alias gwt = git worktree

# jujutsu
export alias ljj = lazyjj

# kubernetes
export alias k = kubectl

# lazygit
export alias lg = lazygit

# ruby
export alias be = bundle exec

# terraform
export alias tf = terraform

# vim / neovim
export alias vi = nvim
export alias vim = nvim
