#
# Some circleci cli aliases
#

if ! command_exists "cookiecutter"; then
  return 1
fi

export COOKIECUTTER_CONFIG="${XDG_CONFIG_HOME}/cookiecutter/config.yaml"

#
# Aliases
#

alias cookiec="cookiecutter"
