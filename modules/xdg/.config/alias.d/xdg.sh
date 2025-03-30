#
# The following cannot be configured to use XDG through environment variables alone
#   https://wiki.archlinux.org/title/XDG_Base_Directory
#

# Subversion
alias svn='svn --config-dir ${XDG_CONFIG_HOME}/subversion'

# Wget
alias wget='wget --hsts-file="${XDG_CACHE_HOME}/wget-hsts"'
