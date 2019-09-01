#
# Initialize scala module
#

# lazy triggers for sdkman
if function_exists "_sdk_lazy_init_cmd"; then
  _sdk_lazy_init_cmd "sbt"
  _sdk_lazy_init_cmd "scala"
fi

if command_exists "scala" || command_exists "sbt"; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/scala/aliases.sh"
fi
