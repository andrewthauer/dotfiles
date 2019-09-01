#
# Initialize java module
#

JAVA_LAZY_TRIGGERS=(java javac mvn gradle)

_jenv_init() {
  # cleanup
  unset -f $0
  unset -f ${JAVA_LAZY_TRIGGERS[@]}
  unset JAVA_LAZY_TRIGGERS

  # expensive operation
  eval "$(jenv init - --no-rehash)"
}

_jenv_lazy_init() {
  triggers=($@)
  for cmd in "${triggers[@]}"; do
    eval "${cmd}() { _jenv_init; ${cmd} \$@; }"
  done
  unset -f $0
}

# initialize with sdkman (lazy)
if [[ -n "$SDKMAN_DIR" ]] && function_exists "_sdk_lazy_init_cmd"; then
  _sdk_lazy_init_cmd "${JAVA_LAZY_TRIGGERS[@]}"

# initialize with jenv (lazy)
elif command_exists "jenv"; then
  _jenv_lazy_init "${JAVA_LAZY_TRIGGERS[@]}"
fi

if command_exists "java"; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/java/aliases.sh"
fi
