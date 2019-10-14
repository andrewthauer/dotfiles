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
  export PATH="${JENV_ROOT}/shims:${PATH}"
  export JENV_SHELL="${SHELL}"
  if [[ -f "${JENV_ROOT}/version" ]]; then
    JENV_VERSION="$(cat ${JENV_ROOT}/version)"
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
  _jenv_lazy_init

# Load manually installed jenv into the shell session
elif [[ -s "${JENV_ROOT}/bin/jenv" ]]; then
  export PATH="${JENV_ROOT}/bin:${PATH}"
  _jenv_lazy_init

# Load java with sdkman candidate
elif [[ -d "${SDKMAN_DIR}/candidates/java" ]]; then
  require_once "sdkman"
  export JAVA_HOME="${SDKMAN_DIR}/candidates/java/current"
  export JDK_HOME="${JAVA_HOME}"
  export PATH="${JAVA_HOME}/shims:${PATH}"
  unset -f _java_jenv_init

# Return if requirements not found
elif ! command_exists "java"; then
  unset -f _java_jenv_init
  return 1
fi
