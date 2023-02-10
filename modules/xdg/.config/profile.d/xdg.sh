#
# Setup misc xdg specifications not in other modules
#

# Gradle
export GRADLE_USER_HOME="${XDG_DATA_HOME}/gradle"

# Subversion
# export SUBVERSION_HOME="${XDG_CONFIG_HOME}/subversion"
alias svn='svn --config-dir ${XDG_CONFIG_HOME}/subversion'

# Vargrant
# export VAGRANT_HOME="${XDG_DATA_HOME}/vagrant"
# export VAGRANT_ALIAS_FILE="${XDG_DATA_HOME}/vagrant/aliases"
