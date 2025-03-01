# Check for custom dotfiles path
if test -f "$XDG_CONFIG_HOME/dotfiles-path"
  set dotfiles_path (cat "$XDG_CONFIG_HOME/dotfiles-path")
  set -gx DOTFILES_PATH $dotfiles_path
end

# Setup default dotfiles env vars
if not set -q DOTFILES_PATH
  set -gx DOTFILES_PATH $HOME/.dotfiles
end

# load environment
# https://gist.github.com/nikoheikkila/dd4357a178c8679411566ba2ca280fcc

if status is-interactive
  # Commands to run in interactive sessions can go here
  set -U fish_greeting
end
