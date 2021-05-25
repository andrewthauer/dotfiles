#
# SSH aliases
#

wget() {
  # Override the wgetrc location
  export WGETRC="${XDG_CONFIG_HOME}/wgetrc"
  unset -f "$0"
  wget --hsts-file="${XDG_CACHE_HOME}/wget-hsts" "$@"
}
