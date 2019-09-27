#
# Initialize sdkman environment
#
# - https://sdkman.io/
#

export SDKMAN_DIR="${XDG_DATA_HOME}/sdkman"

# skip the rest if sdkman is not installed
if [[ ! -d "${SDKMAN_DIR}" ]]; then
  unset SDKMAN_DIR
  return 1
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
  lazyfunc _sdk_init "${SDK_LAZY_TRIGGERS[@]}"
}

_sdk_init() {
  # expensive operation
  source "${SDKMAN_DIR}/bin/sdkman-init.sh"
  unset -f sdk_lazy_init_cmd
  unset -f "$0"
  unset SDK_LAZY_TRIGGERS
}

# initialize sdkman if installed (lazy)
if [[ -d "${SDKMAN_DIR}" ]]; then
  sdk_lazy_init_cmd "sdk"
  # _sdk_init
fi
