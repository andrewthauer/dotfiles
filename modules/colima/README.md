# Colima

## Setup

```sh
# Install colima, docker, docker-compose and docker-buildx
brew install colima docker docker-compose docker-buildx

# Setup docker-compose and set buildx as the default docker build engine
mkdir -p ~/.docker/cli-plugins
ln -sfn $(brew --prefix)/opt/docker-buildx/bin/docker-buildx ~/.docker/cli-plugins/docker-buildx
ln -sfn $(brew --prefix)/opt/docker-compose/bin/docker-compose ~/.docker/cli-plugins/docker-compose
docker buildx install

# startup colima, which will use the docker runtime by default
colima start --runtime docker --cpu 2 --memory 6 --ssh-config=false
```

Or using `containerd` as the runtime:

```sh
brew install colima
colima start --runtime containerd --ssh-config false
colima nerdctl install
```

## Resources

- [Colima](https://github.com/abiosoft/colima)
- [Lima](https://lima-vm.io/)
- [nerdctl](https://github.com/containerd/nerdctl)
- [containerd](https://containerd.io/)
