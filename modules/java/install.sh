#!/usr/bin/env bash
#
# Installs java toolchain
#

# install jenv
brew install jenv
exec $SHELL -l

# make sure JAVA_HOME is set
jenv enable-plugin export
exec $SHELL -l

# add maven plugin
# jenv enable-plugin maven

# install latest java
brew cask install java
jenv add $(/usr/libexec/java_home)

# add all other versions (if installed)
# TODO: make cross platform
jvm_dir="/Library/Java/JavaVirtualMachines"
for dir in "$jvm_dir"/*; do
  jenv add "$dir/Contents/Home"
done

# set default global version
jenv global system
VERSION=$(jenv versions | grep -v "[a-zA-Z]" | tail -n 1 | tr -d ' ')
jenv global $VERSION
