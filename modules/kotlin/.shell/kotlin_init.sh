#
# Initialize kotlin environment
#
# - https://kotlinlang.org/
#

require_once "sdkman"
require_once "java"

# initialize with sdkman (lazy)
if ! command_exists "kotlin" && sdk_candidate_enabled "kotlin"; then
  triggers=(kotlin kotlinc)
  sdk_lazy_init_cmd "${triggers[@]}"
  unset triggers
fi
