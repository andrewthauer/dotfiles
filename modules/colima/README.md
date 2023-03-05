# Colima

## Setup

```sh
# install colima, docker, and docker-buildx
brew install colima docker docker-buildx

# setup buildx as the default docker build engine
mkdir -p ~/.docker/cli-plugins
ln -sfn $(brew --prefix)/opt/docker-buildx/bin/docker-buildx ~/.docker/cli-plugins/docker-buildx
docker buildx install

# startup colima, which will use the docker runtime by default
colima start
```

Or using `containerd` as the runtime:

```sh
brew install colima
colima start --runtime containerd
colima nerdctl install
```

## Resources

- [Colima](https://github.com/abiosoft/colima)
- [Lima](https://lima-vm.io/)
- [nerdctl](https://github.com/containerd/nerdctl)
- [containerd](https://containerd.io/)
