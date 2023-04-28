#
# Initialize deno environment
#

if ! command_exists deno; then
  return 1
fi

# XDG specification
export DENO_INSTALL_ROOT="${XDG_DATA_HOME:-$HOME/.local/share}/deno"

# Add deno install root to path
if [ -d "$DENO_INSTALL_ROOT/bin" ]; then
  append_path "$DENO_INSTALL_ROOT/bin"
fi
