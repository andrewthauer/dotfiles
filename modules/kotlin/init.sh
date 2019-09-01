#
# Initialize kotlin module
#

# lazy triggers for sdkman
if function_exists "_sdk_lazy_init_cmd"; then
  _sdk_lazy_init_cmd "kotlin"
  _sdk_lazy_init_cmd "kotlinc"
fi

if command_exists "kotlin"; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/kotlin/aliases.sh"
fi
