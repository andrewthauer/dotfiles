#
# Initialize java environment
#
# - https://github.com/jenv/jenv
# - https://sdkman.io/
#

export JENV_ROOT="${XDG_DATA_HOME}/jenv"

_jenv_init() {
  # expensive operation
  # eval "$(jenv init - --no-rehash)"

  # faster alternative to `jenv init`
  export JENV_SHELL="${SHELL}"
  export PATH="${JENV_ROOT}/shims:${PATH}"

  # Rehash in the background
  # (jenv rehash &) 2> /dev/null

  unset -f "$0"
}

# Load package manager installed jenv into shell session
if command_exists "jenv"; then
  _jenv_init

# Load manually installed jenv into the shell session
elif [[ -s "${JENV_ROOT}/bin/jenv" ]]; then
  export PATH="${JENV_ROOT}/bin:${PATH}"
  _jenv_init

# Load sdkman (lazy)
elif [[ -n "${SDKMAN_DIR}" ]]; then
  require_once "sdkman"
  # lazy load java
  JAVA_LAZY_TRIGGERS=(java javac)
  sdk_candidate_enabled "java" && sdk_lazy_init_cmd "${JAVA_LAZY_TRIGGERS[@]}"
  unset JAVA_LAZY_TRIGGERS
  # TODO: Split these into their own modules?
  sdk_candidate_enabled "maven" && sdk_lazy_init_cmd "mvn"
  sdk_candidate_enabled "gradle" && sdk_lazy_init_cmd "gradle"
  unset -f _jenv_init

# Return if requirements not found
elif ! command_exists "java"; then
  unset -f _jenv_init
  return 1
fi

#
# XDG specifications
#

# export GRADLE_USER_HOME="${XDG_DATA_HOME}/gradle"
# mvn -gs "$XDG_CONFIG_HOME"/maven/settings.xml
