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
