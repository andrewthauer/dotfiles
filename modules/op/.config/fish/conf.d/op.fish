# Exit early if op is not installed
if not type -q op
  return 1
end

echo "op is installed, loading op configuration..."

# Initial plugins
if test -f "$XDG_CONFIG_HOME/op/plugins.sh"
  source "$XDG_CONFIG_HOME/op/plugins.sh"
end
