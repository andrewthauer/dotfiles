#!/usr/bin/env bash
#
# Setup local kafka tools
#

install_confluent_cli() {
  curl -sL https://cnfl.io/cli | sh -s -- latest -b "${XDG_BIN_HOME}"

  confluent completion bash >|"${XDG_DATA_HOME}/bash_completion.d/confluent"
  confluent completion zsh >|"${XDG_DATA_HOME}/zsh/functions/_confluent"
}

install_confluent_cloud_cli() {
  curl -L --http1.1 https://cnfl.io/ccloud-cli | sh -s -- -b "${XDG_BIN_HOME}"

  ccloud completion bash >|"${XDG_DATA_HOME}/bash_completion.d/ccloud"
  ccloud completion zsh >|"${XDG_DATA_HOME}/zsh/functions/_ccloud"
}

main() {
  if confirm "Install the Confluent CLI tools"; then
    install_confluent_cli
    install_confluent_cloud_cli
  fi
}

main
