# Setup dotfiles env vars
set -gx DOTFILES_DIR $HOME/.dotfiles

# load environment
# https://gist.github.com/nikoheikkila/dd4357a178c8679411566ba2ca280fcc

if status is-interactive
  # Commands to run in interactive sessions can go here
  set -U fish_greeting
end

# source tools
direnv hook fish | source
mise activate fish | source
starship init fish | source
zoxide init fish | source
