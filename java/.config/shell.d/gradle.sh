#
# Initialize gradle environment
#

# Return if requirements not found
if ! command_exists "gradle"; then
  return 1
fi

# XDG specifications
export GRADLE_USER_HOME="${XDG_DATA_HOME}/gradle"
