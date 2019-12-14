#
# Oracle environment
#

# Load oracle from brew
if [[ -f "/usr/local/bin/sqlplus" ]]; then
  # export ORACLE_HOME="/usr/local/opt/instantclient-sqlplus"
  # export DYLD_LIBRARY_PATH="${ORACLE_HOME}/lib"
  echo "n/a" >/dev/null

# Return if requirements not found
else
  return 1
fi

#
# XDG specification
#

export TNS_ADMIN="${XDG_CONFIG_HOME}/oracle/network/admin"
