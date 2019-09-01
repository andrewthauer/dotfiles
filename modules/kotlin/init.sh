#
# Initialize kotlin module
#

# initialize with sdkman (lazy)
if [[ -n "$SDKMAN_DIR" ]] && function_exists "_sdk_lazy_init_cmd"; then
  triggers=(kotlin kotlinc)
  _sdk_lazy_init_cmd "${triggers[@]}"
fi

if command_exists "kotlin"; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/kotlin/aliases.sh"
fi
