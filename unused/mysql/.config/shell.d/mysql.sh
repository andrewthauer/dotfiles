#
# MySQL
#

# Create XDG directories if needed
[ ! -d "${XDG_DATA_HOME}/mysql" ] && mkdir "${XDG_DATA_HOME}/mysql"

# XDG config
export MYSQL_HISTFILE="${XDG_DATA_HOME}/mysql/history"

# Add mysql binaries to path
if [ -d "/usr/local/opt/mysql-client/bin" ]; then
  prepend_path "/usr/local/opt/mysql-client/bin"
fi
