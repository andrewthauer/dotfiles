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
# function envsource
#   for line in (cat $argv | grep -v '^#')
#     set item (string split -m 1 '=' $line)
#     set -gx $item[1] $item[2]
#     echo "Exported key $item[1]"
#   end
# end
# echo "loading env"
# for env_file in "$XDG_CONFIG_HOME/environment.d"/*.conf
#   # echo "$env_file"
#   for line in (cat $env_file | grep -v -E '^$|^#')
#     set item (string split -m 1 '=' $line)
#     echo $item
#     # set -gx "$item[1]" "$item[2]"
#     # echo "Exported key $item[1]"
#   end
# end

if status is-interactive
  # Commands to run in interactive sessions can go here
  set -U fish_greeting
end
