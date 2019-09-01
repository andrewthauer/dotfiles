#!/usr/bin/env bash
#
# Installs java toolchain
#

set -e

install_jenv() {
  return
  brew install jenv

  # make sure JAVA_HOME is set
  jenv enable-plugin export
  exec $SHELL -l

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

install_sdk() {
  "${DOTFILES_DIR}/modules/sdkman/install.sh"
}

install_with_brew() {
  # install latest version
  brew cask install java

  # install java 8
  # brew cask install homebrew/cask-versions/adoptopenjdk8
}

install_with_sdk() {
  # need to source sdkman since it is a shell function
  source "${DOTFILES_DIR}/modules/sdkman/init.sh"

  # install latest version
  sdk install java

  # reload shell
  exec $SHELL -l
}

install_version_manager() {
  PS3="Which java version manager do you want to use?: "
  options=("jenv" "sdkman" "none" "quit")
  select opt in "${options[@]}"; do
  case $opt in
    "jenv")     echo "Using $opt ..."; install_jenv; break;;
    "sdkman")   echo "Using $opt ..."; install_sdk; break;;
    "none")     break;;
    "quit")     exit 0;;
    *)          echo "invalid option $REPLY";;
  esac
  done
  VERSION_MANAGER="$opt"
}

install_java() {
  PS3="How do you want to install java?: "
  options=("homebrew" "sdkman" "skip" "quit")
  select opt in "${options[@]}"; do
  case $opt in
    "homebrew")   echo "Using $opt ..."; install_with_brew; break;;
    "sdkman")     echo "Using $opt ..."; install_with_sdk; break;;
    "skip")       break;;
    "quit")       exit 0;;
    *)            echo "invalid option $REPLY";;
  esac
  done
}

install_maven() {
  if confirm "Do you want to install maven"; then
    if [[ "$VERSION_MANAGER" == "jen" ]]; then
      brew install maven
      jenv enable-plugin maven
    elif [[ "$VERSION_MANAGER" == "sdkman" ]]; then
      sdk install maven
    fi
  fi
}

install_gradle() {
  if confirm "Do you want to install gradle"; then
    if [[ "$VERSION_MANAGER" == "jen" ]]; then
      brew install gradle
      jenv enable-plugin gradle
    elif [[ "$VERSION_MANAGER" == "sdkman" ]]; then
      sdk install gradle
    fi
  fi
}

run() {
  install_version_manager
  install_java
  install_maven
  install_gradle
}

run
exit 0
