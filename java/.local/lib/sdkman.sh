#
# Initialize sdkman environment
#

export SDKMAN_DIR="${XDG_DATA_HOME}/sdkman"

_sdk_init() {
  # expensive operation
  source "${SDKMAN_DIR}/bin/sdkman-init.sh"
}

_sdk_lazy_init() {
  SDK_LAZY_TRIGGERS=("sdk")
  lazyfunc _sdk_init "${SDK_LAZY_TRIGGERS[@]}"
  unset SDK_LAZY_TRIGGERS
  unset -f "$0"
}

# Load sdkman from manual install
if [[ -d "${SDKMAN_DIR}" ]]; then
  _sdk_lazy_init
  # _sdk_init

# Return if requirements not found
else
  unset SDKMAN_DIR
  unset -f _sdk_init
  return 1
fi
