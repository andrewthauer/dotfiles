# Colima

## Setup

```sh
# Run the base docker setup
$DOTFILES_DIR/modules/docker/install.sh

# startup colima, which will use the docker runtime by default
colima start --runtime docker --cpu 2 --memory 6 --ssh-config=false
```

Or using `containerd` as the runtime:

```sh
brew install colima
colima start --runtime containerd --ssh-config=false
colima nerdctl install
```

## Resources

- [Colima](https://github.com/abiosoft/colima)
- [Lima](https://lima-vm.io/)
- [nerdctl](https://github.com/containerd/nerdctl)
- [containerd](https://containerd.io/)
