#
# Initialize sdkman
#

# skip the rest if sdkman is not installed
if [[ ! -d "${HOME}/.sdkman" ]]; then
  return
fi

_sdk_init() {
  # expensive function call
  source "${SDKMAN_DIR}/bin/sdkman-init.sh"

  # unregister
  unset -f _sdk_lazy_init_cmd
  unset -f "$0"
}

_sdk_lazy_init_cmd() {
  cmd=$1
  eval "${cmd}() { unset -f ${cmd}; _sdk_init; ${cmd} \$@; }"
}

_sdk_lazy_init() {
  _sdk_lazy_init_cmd "sdk"
  unset -f "$0"
}

if [[ -d "${HOME}/.sdkman" ]]; then
  export SDKMAN_DIR="${HOME}/.sdkman"
  _sdk_lazy_init
fi
