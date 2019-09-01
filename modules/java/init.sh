#
# Initialize java module
#

JAVA_LAZY_TRIGGERS=(java javac)

_jenv_init() {
  # expensive operation(s)
  # ensure sdkman is loaded first to allow path priority to jenv
  function_exists "_sdk_init" && _sdk_init
  eval "$(jenv init - --no-rehash)"
  unset JAVA_LAZY_TRIGGERS
}

# initialize with jenv (lazy)
if command_exists "jenv"; then
  JAVA_LAZY_TRIGGERS+=(jenv)
  __lazyfunc _jenv_init "${JAVA_LAZY_TRIGGERS[@]}"

# initialize with sdkman (lazy)
elif [[ -n "${SDKMAN_DIR}" ]]; then
  sdk_candidate_enabled "java" && sdk_lazy_init_cmd "${JAVA_LAZY_TRIGGERS[@]}"

  # TODO: Split these into their own modules?
  sdk_candidate_enabled "maven" && sdk_lazy_init_cmd "mvn"
  sdk_candidate_enabled "gradle" && sdk_lazy_init_cmd "gradle"
fi

if command_exists "java"; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/java/aliases.sh"
fi
