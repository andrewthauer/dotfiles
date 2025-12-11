# Exit early if op is not installed
if ! command -v "op" >/dev/null 2>&1; then
  return 1
fi

# Initial plugins
if [ -f "${XDG_CONFIG_HOME}/op/plugins.sh" ]; then
  # shellcheck source=./plugins.sh disable=SC1091
  source_file "${XDG_CONFIG_HOME}/op/plugins.sh"
fi
