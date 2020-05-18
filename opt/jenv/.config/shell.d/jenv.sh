#
# Initialize java environment
#

export JENV_ROOT="${XDG_DATA_HOME}/jenv"

_jenv_init() {
  # expensive operation
  eval "$(jenv init - --no-rehash)"

  # Rehash in the background
  # (jenv rehash &) 2> /dev/null
}

_jenv_lazy_init() {
  unset -f "$0"

  # faster alternative to full 'jenv init'
  prepend_path "${JENV_ROOT}/shims"
  export JENV_SHELL="${CURRENT_SHELL:-$SHELL}"
  if [[ -f "${JENV_ROOT}/version" ]]; then
    JENV_VERSION="$(cat "${JENV_ROOT}"/version)"
    export JAVA_HOME="${JENV_ROOT}/versions/${JENV_VERSION}"
    export JDK_HOME="${JAVA_HOME}"
    export JENV_FORCEJAVAHOME=true
    export JENV_FORCEJDKHOME=true
    unset JENV_VERSION
  fi

  # lazy initialize
  lazyfunc _jenv_init jenv
}

# Load package manager installed jenv into shell session
if command_exists "jenv"; then
  export JAVA_HOME="${SDKMAN_DIR}/candidates/java/current"
  export JDK_HOME="${JAVA_HOME}"

# Load manually installed jenv into the shell session
elif [[ -s "${JENV_ROOT}/bin/jenv" ]]; then
  prepend_path "${JENV_ROOT}/bin"
  _jenv_lazy_init

# Return if requirements not found
else
  unset JENV_ROOT
  unset -f _jenv_lazy_init
  unset -f _jenv_init
  return 1
fi
