#!/usr/bin/env bash
#
# Installs java toolchain
#

set -e

install_with_sdk() {
  # need to source sdkman since it is a shell function
  source "${DOTFILES_DIR}/modules/sdkman/init.sh"

  # install latest version
  sdk install java

  # install build tools
  sdk install maven
  sdk install gradle

  # reload shell
  exec $SHELL -l
}

# install version manager
install_with_jenv() {
  brew install jenv maven gradle
  exec $SHELL -l

  # make sure JAVA_HOME is set
  jenv enable-plugin export
  exec $SHELL -l

  # enable plugins
  jenv enable-plugin maven
  jenv enable-plugin gradle

  # install java versions
  brew cask install java
  brew cask install homebrew/cask-versions/adoptopenjdk8

  # add java home
  jenv add $(/usr/libexec/java_home)

  # add all other versions (if installed)
  # TODO: make cross platform
  jvm_dir="/Library/Java/JavaVirtualMachines"
  for dir in "$jvm_dir"/*; do
    jenv add "$dir/Contents/Home"
  done

  # set default global version
  jenv global system
  jenv global 1.8
}

install_with_sdk
