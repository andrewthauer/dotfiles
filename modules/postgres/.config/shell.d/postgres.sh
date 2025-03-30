# XDG specification
[ ! -d "${XDG_CONFIG_HOME}/pg" ] && mkdir -p "${XDG_CONFIG_HOME}/pg"
[ ! -d "${XDG_CACHE_HOME}/pg" ] && mkdir "${XDG_CACHE_HOME}/pg"

# Add postgres binaries to path for homebrew
if [ -d "${HOMEBREW_PREFIX}/opt/libpq/bin" ]; then
  prepend_path "${HOMEBREW_PREFIX}/opt/libpq/bin"
fi
