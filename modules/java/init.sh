#
# Initialize java module
#

JAVA_LAZY_TRIGGERS=(java javac)

_jenv_init() {
  # cleanup
  unset -f $0
  unset -f ${JAVA_LAZY_TRIGGERS[@]}
  unset JAVA_LAZY_TRIGGERS

  # expensive operation(s)
  # ensure sdkman is loaded first to allow path priority to jenv
  function_exists "_sdk_init" && _sdk_init
  eval "$(jenv init - --no-rehash)"
}

_jenv_lazy_init() {
  triggers=($@)
  for cmd in "${triggers[@]}"; do
    eval "${cmd}() { _jenv_init; ${cmd} \$@; }"
  done
  unset -f $0
}

# initialize with jenv (lazy)
if command_exists "jenv"; then
  JAVA_LAZY_TRIGGERS+=(jenv)
  _jenv_lazy_init "${JAVA_LAZY_TRIGGERS[@]}"

# initialize with sdkman (lazy)
elif [[ -n "${SDKMAN_DIR}" ]]; then
  sdk_candidate_enabled "java" && sdk_lazy_init_cmd "${JAVA_LAZY_TRIGGERS[@]}"
  sdk_candidate_enabled "maven" && sdk_lazy_init_cmd "mvn"
  sdk_candidate_enabled "gradle" && sdk_lazy_init_cmd "gradle"
fi

if command_exists "java"; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/java/aliases.sh"
fi
