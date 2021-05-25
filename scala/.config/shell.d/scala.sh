#
# Initialize scala environment
#

# Return if requirements not found
if ! command_exists "sbt"; then
  return 1
fi

#
# XDG specifications
#

alias sbt='sbt -ivy "${XDG_DATA_HOME}/ivy2" -sbt-dir "${XDG_DATA_HOME}/sbt"'
