#
# Oracle environment
#

# Load oracle from brew
if [[ -f "/usr/local/bin/sqlplus" ]]; then
  # export ORACLE_HOME="${OIC_DIR}"
  export DYLD_LIBRARY_PATH="${BREW_PREFIX}/lib"

# Load oracle from custom directory
elif [[ -d "${HOME}/.local/lib/oracle/instantclient" ]]; then
  export ORACLE_HOME="${HOME}/.local/lib/oracle/instantclient"
  export DYLD_LIBRARY_PATH="${ORACLE_HOME}/lib"
  PATH="${ORACLE_HOME}/bin:${PATH}"

# Return if requirements not found
else
  return 1
fi

#
# XDG specification
#

export TNS_ADMIN="${XDG_CONFIG_HOME}/oracle/network/admin"
