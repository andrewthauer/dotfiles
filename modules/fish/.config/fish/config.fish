# Check for custom dotfiles home
if test -f "$XDG_CONFIG_HOME/dotfiles-home"
  set -gx DOTFILES_HOME $(cat "$XDG_CONFIG_HOME/dotfiles-home")
end

# Setup default dotfiles env vars
if not set -q DOTFILES_HOME
  set -gx DOTFILES_HOME $HOME/.dotfiles
end

# TODO: load environment
# https://gist.github.com/nikoheikkila/dd4357a178c8679411566ba2ca280fcc

if status is-interactive
  # Commands to run in interactive sessions can go here
  set -U fish_greeting
end
