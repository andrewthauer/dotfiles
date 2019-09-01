#
# Initialize java module
#

_jenv_init() {
  # expensive function call
  eval "$(jenv init - --no-rehash)"
  unset -f "$0"
}

_jenv_lazy_init() {
  triggers=(jenv java javac mvn)
  for cmd in "${triggers[@]}"; do
    eval "${cmd}() { unset -f ${triggers}; _jenv_init; ${cmd} \$@; }"
  done

  unset -f "$0"
}

# initialize jenv (lazy)
if command_exists "jenv"; then
  _jenv_lazy_init
fi

# lazy triggers for sdkman
if function_exists "_sdk_lazy_init_cmd"; then
  _sdk_lazy_init_cmd "java"
  _sdk_lazy_init_cmd "javac"
  _sdk_lazy_init_cmd "maven"
  _sdk_lazy_init_cmd "gradle"
fi

if command_exists "java"; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/java/aliases.sh"
fi
