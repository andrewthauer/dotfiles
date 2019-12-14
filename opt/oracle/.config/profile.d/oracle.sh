#
# Oracle environment
#

# Load oracle from brew
if [[ -f "/usr/local/bin/sqlplus" ]]; then
  # export ORACLE_HOME="/usr/local/opt/instantclient-sqlplus"
  # export DYLD_LIBRARY_PATH="${ORACLE_HOME}/lib"
  echo "n/a" >/dev/null
fi

# XDG specification
export TNS_ADMIN="${XDG_CONFIG_HOME}/oracle/network/admin"
