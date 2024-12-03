#
# Initialize maven environment
#

#
# XDG specification
#

export MAVEN_OPTS=-Dmaven.repo.local="${XDG_DATA_HOME}"/maven/repository

# Override the config/cache location
alias mvn='mvn -gs "${XDG_CONFIG_HOME}/maven/settings.xml"'
