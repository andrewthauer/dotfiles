#
# Dotenv helpers & aliases
#
# Note:
#   On macOS `envsubst` requires gettext:
#     brew install gettext
#     brew link --force gettext
#

dotenv() {
  local cmd=$1
  local args=${@:2}
  local dotenv_cmd="dotenv-${cmd}"

  # Execute the command
  if [ $(command -v $dotenv_cmd) ]; then
    $dotenv_cmd $args 2>&1
  else
    dotenv-read
  fi
}

dotenv-read() {
  local file="${DOTENV_FILE:-${1:-.env}}"
  cat "${file}" | grep -v "^#" | grep -v -e "^$"
}

dotenv-exec() {
  env $(dotenv-read) "${@:1}"
}

dotenv-export() {
  export $(dotenv-read | xargs)
}

dotenv-subst() {
  if ! [ -x "$(command -v envsubst)" ]; then
    echo "Command 'envsubst' not found. Please install the 'gettext' package"
    exit 1
  fi

  dotenv-exec envsubst < "${1}"
}
