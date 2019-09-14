#
# Jenv utilities
#
# - https://github.com/jenv/jenv
#

if ! command_exists "jenv"; then
  return
fi

function jenv-add-all() {
  # latest version (system)
  jenv add $(/usr/libexec/java_home)

  # other versions
  jvm_dir="/Library/Java/JavaVirtualMachines"
  for dir in "$jvm_dir"/*; do
    jenv add "$dir/Contents/Home"
  done
}

function jenv-set-global-latest() {
  jenv global system
  VERSION=$(jenv versions | grep -v "[a-zA-Z]" | tail -n 1 | tr -d ' ')
  jenv global $VERSION
  jenv version
}
