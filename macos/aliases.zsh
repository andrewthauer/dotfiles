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
  local search_path=$1
  if [ -v $1 ]; then
    search_path="."
  fi
  find "${search_path}" -iname ".DS_Store" -delete
}
