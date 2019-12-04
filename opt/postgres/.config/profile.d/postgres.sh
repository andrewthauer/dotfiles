#
# Postgres
#

# Xdg directories
[[ ! -d "${XDG_CONFIG_HOME}/pg" ]] && mkdir -p "${XDG_CONFIG_HOME}/pg"
[[ ! -d "${XDG_CACHE_HOME}/pg" ]] && mkdir "${XDG_CACHE_HOME}/pg"

# Xdg config
export PSQLRC="${XDG_CONFIG_HOME}/pg/psqlrc"
export PSQL_HISTORY="${XDG_CACHE_HOME}/pg/psql_history"
export PGPASSFILE="${XDG_CONFIG_HOME}/pg/pgpass"
export PGSERVICEFILE="${XDG_CONFIG_HOME}/pg/pg_service.conf"

# Add postgres binaries to path
if [[ -d "/usr/local/opt/libpq/bin" ]]; then
  PATH="/usr/local/opt/libpq/bin:$PATH"
fi
