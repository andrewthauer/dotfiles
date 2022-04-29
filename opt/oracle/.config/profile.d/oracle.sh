#
# Oracle environment
#

# Load oracle from brew prefix
if [[ -f "/usr/local/bin/sqlplus" ]]; then
  export ORACLE_HOME="/usr/local/opt/instantclient-sqlplus"
  export DYLD_LIBRARY_PATH="${ORACLE_HOME}/lib"
  prepend_path "${ORACLE_HOME}/bin"
fi

# XDG specification
export TNS_ADMIN="${XDG_CONFIG_HOME}/oracle/network/admin"
