#
# MySQL
#

# Xdg directories
[[ ! -d "${XDG_DATA_HOME}/mysql" ]] && mkdir "${XDG_DATA_HOME}/mysql"

# Xdg config
export MYSQL_HISTFILE="${XDG_DATA_HOME}/mysql/history"
