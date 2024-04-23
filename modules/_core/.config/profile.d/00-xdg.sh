#
# Setup misc xdg specifications not in other modules
#   https://wiki.archlinux.org/title/XDG_Base_Directory
#

# CocoaPods
export CP_HOME_DIR="${XDG_DATA_HOME}/cocoapods"

# Gradle
export GRADLE_USER_HOME="${XDG_DATA_HOME}/gradle"

# Subversion
# export SUBVERSION_HOME="${XDG_CONFIG_HOME}/subversion"
alias svn='svn --config-dir ${XDG_CONFIG_HOME}/subversion'

# Wget
export WGETRC="${XDG_CONFIG_HOME}/wgetrc"
alias wget='wget --hsts-file="${XDG_CACHE_HOME}/wget-hsts"'
