#!/usr/bin/env bash
#
# Setup local kafka tools
#

install_confluent_cli() {
  curl -sL https://cnfl.io/cli | sh -s -- latest -b "${XDG_BIN_HOME}"

  confluent completion bash >|"${XDG_DATA_HOME}/bash_completion.d/confluent"
  confluent completion zsh >|"${XDG_DATA_HOME}/zsh/functions/_confluent"
}

main() {
  if confirm "Install the Confluent CLI tools"; then
    mkdir -p "${XDG_DATA_HOME}/bash_completion.d"
    mkdir -p "${XDG_DATA_HOME}/zsh/functions"

    install_confluent_cli
  fi
}

main
