#
# macOS aliases
#

#
# Removes all .DS_Store files
#
# Usage:
#   rimraf-dsstore
#   rimraf-dsstore /path/to/search
#
rimraf-dsstore() {
  local path=$1
  if [ -v $1 ]; then
    path="."
  fi
  find "${path}" -iname ".DS_Store" -delete
}
