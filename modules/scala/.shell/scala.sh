#
# Initialize scala environment
#

require_once "sdkman"
require_once "java"

# initialize sbt with sdkman (lazy)
if ! command_exists "sbt" && sdk_candidate_enabled "sbt"; then
  sdk_lazy_init_cmd "sbt"
fi

# initialize scala with sdkman (lazy)
if ! command_exists "scala" && sdk_candidate_enabled "scala"; then
  sdk_lazy_init_cmd "scala"
fi
