#
# Initialize deno environment
#

# XDG specification
export DENO_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/deno"
export DENO_INSTALL_ROOT="${XDG_DATA_HOME:-$HOME/.local/share}/deno"

# Add deno install root to path
if [ -d "$DENO_INSTALL_ROOT/bin" ]; then
  append_path "$DENO_INSTALL_ROOT/bin"
fi

# Aliases
alias dt="deno task"
