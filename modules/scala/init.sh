#
# Initialize scala module
#

# initialize with sdkman (lazy)
if [[ -n "$SDKMAN_DIR" ]] && function_exists "_sdk_lazy_init_cmd"; then
  triggers=(sbt scala)
  _sdk_lazy_init_cmd "${triggers[@]}"
fi

if command_exists "scala" || command_exists "sbt"; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/scala/aliases.sh"
fi
