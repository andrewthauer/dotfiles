#
# Initialize sdkman module
#
# - https://sdkman.io/
#

# skip the rest if sdkman is not installed
if [[ ! -d "${HOME}/.sdkman" ]]; then
  return
fi

# globabl registry of commands that trigger sdkman init
SDK_LAZY_TRIGGERS=()

sdk_candidate_enabled() {
  candidate=${1}
  [[ -s "$SDKMAN_DIR/candidates/$candidate/current" ]]
}

sdk_lazy_init_cmd() {
  # append triggers
  for cmd in "$@"; do
    SDK_LAZY_TRIGGERS+=($cmd)
  done

  # register lazy loaded trigger (force overrides existing)
  __lazyfunc _sdk_init "${SDK_LAZY_TRIGGERS[@]}"
}

_sdk_init() {
  # expensive operation
  source "${SDKMAN_DIR}/bin/sdkman-init.sh"
  unset -f sdk_lazy_init_cmd
  unset SDK_LAZY_TRIGGERS
}

# _sdk_lazy_init() {
#   sdk_lazy_init_cmd "sdk"
#   unset -f $0
# }

# initialize sdkman if installed (lazy)
if [[ -d "${HOME}/.sdkman" ]]; then
  export SDKMAN_DIR="${HOME}/.sdkman"
  sdk_lazy_init_cmd "sdk"
fi
