#
# Initialize scala environment
#

# Load sbt with sdkman candidate
if [[ -d "${XDG_DATA_HOME}/sdkman/candidates/sbt" ]]; then
  source_shell_lib "sdkman"
  export SBT_HOME="${SDKMAN_DIR}/candidates/sbt/current"
  prepend_path "${SBT_HOME}/bin"
  unset SBT_HOME

# Return if requirements not found
elif ! command_exists "sbt"; then
  return 1
fi

#
# XDG specifications
#

alias sbt="sbt -ivy "${XDG_DATA_HOME}/ivy2" -sbt-dir "${XDG_DATA_HOME}/sbt""
