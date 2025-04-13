#
# Load any plugins
#

# Source all module shell scripts
source_files_in "${XDG_CONFIG_HOME}"/shell.d/*.{sh,bash}

# Source all module aliases
source_files_in "${XDG_CONFIG_HOME}"/alias.d/*.{sh,bash}
