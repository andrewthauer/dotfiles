#
# Initialize ruby environment
#
# - https://github.com/rbenv/rbenv
#

# Use asdf if installed
if [[ -d "${XDG_DATA_HOME}/asdf/plugins/ruby" ]]; then
  echo "using asdf" >/dev/null

# Load package manager installed rbenv into shell session
elif command_exists "rbenv" || [[ -s "${XDG_DATA_HOME}/rbenv/bin/rbenv" ]]; then
  source_shell_lib "rbenv"

# Return if requirements not found
elif ! command_exists "ruby"; then
  unset -f _rbenv_init
  return 1
fi

#
# XDG specifications
#

# export GEM_HOME="${XDG_DATA_HOME}/gem"
export GEMRC="${XDG_CONFIG_HOME}/gem/gemrc"
export GEM_SPEC_CACHE="${XDG_CACHE_HOME}/gem/specs"

#
# Bundler
#

if command_exists "bundle"; then
  # Change bundler home to xdg cache
  export BUNDLE_USER_HOME="${XDG_CACHE_HOME}/bundle"
  export BUNDLE_USER_CONFIG="${XDG_CONFIG_HOME}/bundle/config"
  export BUNDLE_USER_PLUGIN="${XDG_DATA_HOME}/bundle/plugin"
  export BUNDLE_USER_CACHE="${XDG_CACHE_HOME}/bundle/cache"

  # For bundler
  if [[ -z "${GITHUB_TOKEN}" ]]; then
    BUNDLE_GITHUB__COM="${GITHUB_TOKEN}:x-oauth-basic"
  fi

  # Aliases
  alias be="bundle exec"
fi

#
# Aliases
#

function gem-install-bundler() {
  gem install bundler -v $(tail -n 1 Gemfile.lock)
}
