#
# Postgres environment
#

#
# Environment
#

# XDG specification
[ ! -d "${XDG_CONFIG_HOME}/pg" ] && mkdir -p "${XDG_CONFIG_HOME}/pg"
[ ! -d "${XDG_CACHE_HOME}/pg" ] && mkdir "${XDG_CACHE_HOME}/pg"

# Add postgres binaries to path
if [ -d "${PROFILE_PREFIX}/opt/libpq/bin" ]; then
  prepend_path "${PROFILE_PREFIX}/opt/libpq/bin"
fi

#
# Aliases
#

# Connect local
alias psql-local='psql -h localhost -U postgres'
