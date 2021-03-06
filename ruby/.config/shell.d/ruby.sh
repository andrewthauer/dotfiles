#
# Initialize ruby environment
#
# - https://github.com/rbenv/rbenv
#

# Return if requirements not found
if ! command_exists "ruby"; then
  return 1
fi

# Ruby build
if [ -n "${BREW_PREFIX}" ]; then
  export RUBY_CONFIGURE_OPTS="--with-openssl-dir=${BREW_PREFIX}/opt/openssl@1.1"
fi

#
# XDG specifications
#

export IRBRC="${XDG_CONFIG_HOME}/irb/irbrc"

# export GEM_HOME="${XDG_DATA_HOME}/gem"
export GEMRC="${XDG_CONFIG_HOME}/gem/gemrc"
export GEM_SPEC_CACHE="${XDG_CACHE_HOME}/gem/specs"

#
# Bundler
#

# Change bundler home to xdg cache
export BUNDLE_USER_HOME="${XDG_CACHE_HOME}/bundle"
export BUNDLE_USER_CONFIG="${XDG_CONFIG_HOME}/bundle/config"
export BUNDLE_USER_PLUGIN="${XDG_DATA_HOME}/bundle/plugin"
export BUNDLE_USER_CACHE="${XDG_CACHE_HOME}/bundle/cache"

# For bundler
if [[ -z "${GITHUB_TOKEN}" ]]; then
  export BUNDLE_GITHUB__COM="${GITHUB_TOKEN}:x-oauth-basic"
fi

function gem-install-bundler() {
  gem install bundler -v "$(tail -n 1 Gemfile.lock)"
}

# Aliases
alias b='bundle'
alias be='bundle exec'
alias bu='bundle update'
