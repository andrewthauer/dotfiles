#!/user/bin/env bash

set -eou pipefail

main() {
  # Install colima, docker, docker-compose and docker-buildx
  brew install colima docker docker-compose docker-buildx

  # Setup docker-compose and set buildx as the default docker build engine
  mkdir -p ~/.docker/cli-plugins
  ln -sfn "$(brew --prefix)"/opt/docker-buildx/bin/docker-buildx ~/.docker/cli-plugins/docker-buildx
  ln -sfn "$(brew --prefix)"/opt/docker-compose/bin/docker-compose ~/.docker/cli-plugins/docker-compose
  docker buildx install
}

main "$@"
