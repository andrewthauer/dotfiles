#
# Initialize ruby environment
#
# - https://github.com/rbenv/rbenv
#

# For bundler
if [ -z "${GITHUB_TOKEN}" ]; then
  export BUNDLE_GITHUB__COM="${GITHUB_TOKEN}:x-oauth-basic"
fi

# Aliases
alias be='bundle exec'
