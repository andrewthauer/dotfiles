#
# Aliases for Nushell
#

# nu aliases
export alias ll = ls -la
export alias ex = explore

# dotfiles
export alias dotdir = cd $env.DOTFILES_DIR

#
# TODO: modularize these
#

# deno
export alias dt = deno task

# git
export alias g = git
export alias gcm = git checkout
export alias gb = git branch
export alias gco = git checkout
export alias gcm = git cm
export alias gs = git switch
export alias gst = git status
export alias gwt = git worktree

# kubernetes
export alias k = kubectl

# mise
export alias m = mise

# ruby
export alias be = bundle exec

# vim / neovim
export alias vi = nvim
export alias vim = nvim
