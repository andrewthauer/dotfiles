#
# Include external files
#

# Load additional shell scripts
_load_shell_scripts() {
  if [ -d "${HOME}/.shell" ]; then
    for file in ${HOME}/.shell/*.sh; do
      [ -f "$file" ] && source "$file"
    done
    unset file;
  fi
  unset -f $0
}
_load_shell_scripts
