#
# Initialize kotlin module
#

# initialize with sdkman (lazy)
if ! command_exists "kotlin" && sdk_candidate_enabled "kotlin"; then
  triggers=(kotlin kotlinc)
  sdk_lazy_init_cmd "${triggers[@]}"
fi

if command_exists "kotlin"; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/kotlin/aliases.sh"
fi
